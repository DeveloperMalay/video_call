import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  final StreamController<MediaStream?> _localStreamController = 
      StreamController<MediaStream?>.broadcast();
  final StreamController<MediaStream?> _remoteStreamController = 
      StreamController<MediaStream?>.broadcast();

  Stream<MediaStream?> get localStream => _localStreamController.stream;
  Stream<MediaStream?> get remoteStream => _remoteStreamController.stream;

  final Map<String, dynamic> _iceServers = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302',
        ]
      },
    ]
  };

  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ]
  };

  final Map<String, dynamic> _dcConstraints = {
    'mandatory': {
      'OfferToReceiveAudio': true,
      'OfferToReceiveVideo': true,
    },
    'optional': [],
  };

  Future<void> initializePeerConnection({
    required Function(RTCIceCandidate) onIceCandidate,
  }) async {
    _peerConnection = await createPeerConnection(_iceServers, _config);

    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      onIceCandidate(candidate);
    };

    _peerConnection?.onAddStream = (MediaStream stream) {
      _remoteStream = stream;
      _remoteStreamController.add(stream);
    };

    _peerConnection?.onIceConnectionState = (RTCIceConnectionState state) {
      // ICE Connection State changed
    };
  }

  Future<void> getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      }
    };

    try {
      _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localStreamController.add(_localStream);
      
      if (_peerConnection != null) {
        await _peerConnection!.addStream(_localStream!);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RTCSessionDescription> createOffer() async {
    RTCSessionDescription description = await _peerConnection!.createOffer(_dcConstraints);
    await _peerConnection!.setLocalDescription(description);
    return description;
  }

  Future<RTCSessionDescription> createAnswer() async {
    RTCSessionDescription description = await _peerConnection!.createAnswer(_dcConstraints);
    await _peerConnection!.setLocalDescription(description);
    return description;
  }

  Future<void> setRemoteDescription(RTCSessionDescription description) async {
    await _peerConnection?.setRemoteDescription(description);
  }

  Future<void> addCandidate(RTCIceCandidate candidate) async {
    await _peerConnection?.addCandidate(candidate);
  }

  void toggleAudio() {
    if (_localStream != null) {
      bool enabled = _localStream!.getAudioTracks()[0].enabled;
      _localStream!.getAudioTracks()[0].enabled = !enabled;
    }
  }

  void toggleVideo() {
    if (_localStream != null) {
      bool enabled = _localStream!.getVideoTracks()[0].enabled;
      _localStream!.getVideoTracks()[0].enabled = !enabled;
    }
  }

  Future<void> switchCamera() async {
    if (_localStream != null) {
      final videoTrack = _localStream!.getVideoTracks()[0];
      await Helper.switchCamera(videoTrack);
    }
  }

  bool get isAudioEnabled {
    return _localStream?.getAudioTracks()[0].enabled ?? false;
  }

  bool get isVideoEnabled {
    return _localStream?.getVideoTracks()[0].enabled ?? false;
  }

  Future<void> dispose() async {
    await _localStream?.dispose();
    await _remoteStream?.dispose();
    await _peerConnection?.close();
    await _peerConnection?.dispose();
    
    await _localStreamController.close();
    await _remoteStreamController.close();
  }
}