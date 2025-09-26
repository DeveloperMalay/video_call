import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SignalingService {
  IO.Socket? socket;
  
  final StreamController<Map<String, dynamic>> _messageController = 
      StreamController<Map<String, dynamic>>.broadcast();
  
  Stream<Map<String, dynamic>> get messages => _messageController.stream;

  // For demo purposes, we'll use a simple peer-to-peer signaling
  // In production, you'd use a proper signaling server
  final StreamController<RTCSessionDescription> _offerController =
      StreamController<RTCSessionDescription>.broadcast();
  final StreamController<RTCSessionDescription> _answerController =
      StreamController<RTCSessionDescription>.broadcast();
  final StreamController<RTCIceCandidate> _candidateController =
      StreamController<RTCIceCandidate>.broadcast();

  Stream<RTCSessionDescription> get offers => _offerController.stream;
  Stream<RTCSessionDescription> get answers => _answerController.stream;
  Stream<RTCIceCandidate> get candidates => _candidateController.stream;

  // Simple in-memory signaling for demo purposes
  static final Map<String, SignalingService> _instances = {};
  static final Map<String, List<Map<String, dynamic>>> _messages = {};

  String? _roomId;

  SignalingService._();

  factory SignalingService.getInstance(String roomId) {
    if (!_instances.containsKey(roomId)) {
      _instances[roomId] = SignalingService._();
      _messages[roomId] = [];
    }
    return _instances[roomId]!;
  }

  Future<void> connect(String roomId) async {
    _roomId = roomId;
    
    // Simulate connection
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Start listening for messages in this room
    _listenForMessages();
  }

  void _listenForMessages() {
    // Simulate listening to messages
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_roomId != null && _messages.containsKey(_roomId)) {
        final roomMessages = _messages[_roomId]!;
        for (var message in roomMessages.toList()) {
          if (message['consumed'] != true) {
            message['consumed'] = true;
            _handleMessage(message);
          }
        }
      }
    });
  }

  void _handleMessage(Map<String, dynamic> message) {
    final type = message['type'];
    
    switch (type) {
      case 'offer':
        final sdp = message['sdp'];
        final offer = RTCSessionDescription(sdp, 'offer');
        _offerController.add(offer);
        break;
      case 'answer':
        final sdp = message['sdp'];
        final answer = RTCSessionDescription(sdp, 'answer');
        _answerController.add(answer);
        break;
      case 'ice-candidate':
        final candidate = RTCIceCandidate(
          message['candidate'],
          message['sdpMid'],
          message['sdpMLineIndex'],
        );
        _candidateController.add(candidate);
        break;
    }
  }

  void sendOffer(RTCSessionDescription offer) {
    final message = {
      'type': 'offer',
      'sdp': offer.sdp,
      'from': 'caller',
      'consumed': false,
    };
    _sendMessage(message);
  }

  void sendAnswer(RTCSessionDescription answer) {
    final message = {
      'type': 'answer',
      'sdp': answer.sdp,
      'from': 'callee',
      'consumed': false,
    };
    _sendMessage(message);
  }

  void sendCandidate(RTCIceCandidate candidate) {
    final message = {
      'type': 'ice-candidate',
      'candidate': candidate.candidate,
      'sdpMid': candidate.sdpMid,
      'sdpMLineIndex': candidate.sdpMLineIndex,
      'consumed': false,
    };
    _sendMessage(message);
  }

  void _sendMessage(Map<String, dynamic> message) {
    if (_roomId != null) {
      if (!_messages.containsKey(_roomId)) {
        _messages[_roomId!] = [];
      }
      _messages[_roomId]!.add(message);
    }
  }

  void joinRoom(String roomId) {
    final message = {
      'type': 'join',
      'room': roomId,
      'consumed': false,
    };
    _sendMessage(message);
  }

  void leaveRoom() {
    if (_roomId != null) {
      final message = {
        'type': 'leave',
        'room': _roomId,
        'consumed': false,
      };
      _sendMessage(message);
    }
  }

  void dispose() {
    socket?.disconnect();
    socket?.dispose();
    _messageController.close();
    _offerController.close();
    _answerController.close();
    _candidateController.close();
  }
}