import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirebaseWebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _callId;
  bool _isCaller = false;
  
  final StreamController<MediaStream?> _localStreamController = 
      StreamController<MediaStream?>.broadcast();
  final StreamController<MediaStream?> _remoteStreamController = 
      StreamController<MediaStream?>.broadcast();
  final StreamController<String> _callStateController = 
      StreamController<String>.broadcast();

  Stream<MediaStream?> get localStream => _localStreamController.stream;
  Stream<MediaStream?> get remoteStream => _remoteStreamController.stream;
  Stream<String> get callState => _callStateController.stream;

  String? get callId => _callId;
  bool get isCaller => _isCaller;
  bool get isAudioEnabled => _localStream?.getAudioTracks().first.enabled ?? false;
  bool get isVideoEnabled => _localStream?.getVideoTracks().first.enabled ?? false;

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
      {'urls': 'stun:stun2.l.google.com:19302'},
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ]
  };

  Future<void> initializeLocalMedia() async {
    try {
      _callStateController.add('Initializing camera...');
      
      _localStream = await navigator.mediaDevices.getUserMedia({
        'video': {
          'facingMode': 'user',
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
        },
        'audio': {
          'echoCancellation': true,
          'noiseSuppression': true,
          'autoGainControl': true,
        }
      });

      _localStreamController.add(_localStream);
      _callStateController.add('Camera ready');
    } catch (e) {
      _callStateController.add('Failed to access camera: $e');
      throw Exception('Failed to initialize media: $e');
    }
  }

  Future<String> createCall() async {
    try {
      _callId = const Uuid().v4();
      _isCaller = true;
      
      _callStateController.add('Creating call...');
      
      await _createPeerConnection();
      
      if (_localStream != null) {
        for (var track in _localStream!.getTracks()) {
          await _peerConnection!.addTrack(track, _localStream!);
        }
      }

      final callDoc = _firestore.collection('calls').doc(_callId);
      
      // Create offer
      final offer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(offer);

      // Store offer in Firestore
      await callDoc.set({
        'offer': {
          'type': offer.type,
          'sdp': offer.sdp,
        },
        'createdAt': FieldValue.serverTimestamp(),
        'callerId': 'caller',
      });

      // Listen for answer
      callDoc.snapshots().listen((snapshot) async {
        final data = snapshot.data();
        if (data != null && data['answer'] != null) {
          final answer = RTCSessionDescription(
            data['answer']['sdp'],
            data['answer']['type'],
          );
          await _peerConnection?.setRemoteDescription(answer);
          _callStateController.add('Call connected!');
        }
      });

      // Listen for ICE candidates
      _listenForCandidates(callDoc);
      
      _callStateController.add('Waiting for someone to join...');
      return _callId!;
    } catch (e) {
      _callStateController.add('Failed to create call: $e');
      throw Exception('Failed to create call: $e');
    }
  }

  Future<void> joinCall(String callId) async {
    try {
      _callId = callId;
      _isCaller = false;
      
      _callStateController.add('Joining call...');
      
      final callDoc = _firestore.collection('calls').doc(callId);
      final snapshot = await callDoc.get();
      
      if (!snapshot.exists) {
        throw Exception('Call not found');
      }

      final data = snapshot.data()!;
      
      await _createPeerConnection();
      
      if (_localStream != null) {
        for (var track in _localStream!.getTracks()) {
          await _peerConnection!.addTrack(track, _localStream!);
        }
      }

      // Set remote description (offer)
      final offer = RTCSessionDescription(
        data['offer']['sdp'],
        data['offer']['type'],
      );
      await _peerConnection!.setRemoteDescription(offer);

      // Create answer
      final answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);

      // Send answer to Firestore
      await callDoc.update({
        'answer': {
          'type': answer.type,
          'sdp': answer.sdp,
        },
        'joinedAt': FieldValue.serverTimestamp(),
        'joinerId': 'joiner',
      });

      // Listen for ICE candidates
      _listenForCandidates(callDoc);
      
      _callStateController.add('Connected to call!');
    } catch (e) {
      _callStateController.add('Failed to join call: $e');
      throw Exception('Failed to join call: $e');
    }
  }

  Future<void> _createPeerConnection() async {
    _peerConnection = await createPeerConnection(_iceServers, _config);

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      if (_callId != null) {
        _firestore
            .collection('calls')
            .doc(_callId)
            .collection('candidates')
            .add({
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
          'type': _isCaller ? 'caller' : 'joiner',
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    };

    _peerConnection!.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        _remoteStreamController.add(event.streams[0]);
      }
    };

    _peerConnection!.onConnectionState = (RTCPeerConnectionState state) {
      switch (state) {
        case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
          _callStateController.add('Connected');
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
          _callStateController.add('Disconnected');
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateFailed:
          _callStateController.add('Connection failed');
          break;
        case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
          _callStateController.add('Call ended');
          break;
        default:
          _callStateController.add('Connecting...');
          break;
      }
    };
  }

  void _listenForCandidates(DocumentReference callDoc) {
    callDoc.collection('candidates').snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data() as Map<String, dynamic>;
          final isFromMe = (_isCaller && data['type'] == 'caller') ||
                          (!_isCaller && data['type'] == 'joiner');
          
          if (!isFromMe) {
            _peerConnection?.addCandidate(
              RTCIceCandidate(
                data['candidate'],
                data['sdpMid'],
                data['sdpMLineIndex'],
              ),
            );
          }
        }
      }
    });
  }

  void toggleAudio() {
    if (_localStream != null && _localStream!.getAudioTracks().isNotEmpty) {
      final audioTrack = _localStream!.getAudioTracks().first;
      audioTrack.enabled = !audioTrack.enabled;
    }
  }

  void toggleVideo() {
    if (_localStream != null && _localStream!.getVideoTracks().isNotEmpty) {
      final videoTrack = _localStream!.getVideoTracks().first;
      videoTrack.enabled = !videoTrack.enabled;
    }
  }

  Future<void> switchCamera() async {
    if (_localStream != null && _localStream!.getVideoTracks().isNotEmpty) {
      final videoTrack = _localStream!.getVideoTracks().first;
      await Helper.switchCamera(videoTrack);
    }
  }

  Future<void> endCall() async {
    try {
      _callStateController.add('Ending call...');
      
      // Clean up Firestore data
      if (_callId != null) {
        await _firestore.collection('calls').doc(_callId).delete();
      }
      
      // Close peer connection
      await _peerConnection?.close();
      _peerConnection = null;
      
      // Stop local media
      await _localStream?.dispose();
      _localStream = null;
      
      _callStateController.add('Call ended');
    } catch (e) {
      _callStateController.add('Error ending call: $e');
    }
  }

  Future<void> dispose() async {
    await endCall();
    await _localStreamController.close();
    await _remoteStreamController.close();
    await _callStateController.close();
  }
}