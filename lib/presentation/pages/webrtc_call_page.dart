import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/services/webrtc_service.dart';
import '../../core/services/signaling_service.dart';
import '../widgets/user_avatar.dart';

class WebRTCCallPage extends StatefulWidget {
  final String roomId;
  final bool isCaller;

  const WebRTCCallPage({
    super.key,
    required this.roomId,
    required this.isCaller,
  });

  @override
  State<WebRTCCallPage> createState() => _WebRTCCallPageState();
}

class _WebRTCCallPageState extends State<WebRTCCallPage> {
  late WebRTCService _webrtcService;
  late SignalingService _signalingService;
  
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  
  bool _isAudioEnabled = true;
  bool _isVideoEnabled = true;
  bool _isFrontCamera = true;
  bool _isConnected = false;
  String? _currentUserName;
  String? _currentUserPhoto;
  
  @override
  void initState() {
    super.initState();
    _getCurrentUserInfo();
    _initialize();
  }

  void _getCurrentUserInfo() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _currentUserName = user.displayName ?? user.email?.split('@').first ?? 'User';
      _currentUserPhoto = user.photoURL;
    } else {
      _currentUserName = 'User';
    }
  }

  Future<void> _initialize() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    
    _webrtcService = WebRTCService();
    _signalingService = SignalingService.getInstance(widget.roomId);
    
    await _setupWebRTC();
    await _setupSignaling();
    
    if (widget.isCaller) {
      await _startCall();
    } else {
      await _waitForCall();
    }
  }

  Future<void> _setupWebRTC() async {
    await _webrtcService.initializePeerConnection(
      onIceCandidate: (RTCIceCandidate candidate) {
        _signalingService.sendCandidate(candidate);
      },
    );

    await _webrtcService.getUserMedia();
    
    _webrtcService.localStream.listen((stream) {
      if (stream != null) {
        _localRenderer.srcObject = stream;
        setState(() {});
      }
    });
    
    _webrtcService.remoteStream.listen((stream) {
      if (stream != null) {
        _remoteRenderer.srcObject = stream;
        setState(() {
          _isConnected = true;
        });
      }
    });
  }

  Future<void> _setupSignaling() async {
    await _signalingService.connect(widget.roomId);
    
    _signalingService.offers.listen((offer) async {
      if (!widget.isCaller) {
        await _webrtcService.setRemoteDescription(offer);
        final answer = await _webrtcService.createAnswer();
        _signalingService.sendAnswer(answer);
      }
    });
    
    _signalingService.answers.listen((answer) async {
      if (widget.isCaller) {
        await _webrtcService.setRemoteDescription(answer);
      }
    });
    
    _signalingService.candidates.listen((candidate) async {
      await _webrtcService.addCandidate(candidate);
    });
  }

  Future<void> _startCall() async {
    _signalingService.joinRoom(widget.roomId);
    final offer = await _webrtcService.createOffer();
    _signalingService.sendOffer(offer);
  }

  Future<void> _waitForCall() async {
    _signalingService.joinRoom(widget.roomId);
    BotToast.showText(
      text: 'Waiting for caller...',
      textStyle: const TextStyle(color: Colors.white),
      contentColor: Colors.orange,
    );
  }

  void _toggleAudio() {
    _webrtcService.toggleAudio();
    setState(() {
      _isAudioEnabled = _webrtcService.isAudioEnabled;
    });
    
    BotToast.showText(
      text: _isAudioEnabled ? 'Audio enabled' : 'Audio disabled',
      textStyle: const TextStyle(color: Colors.white),
      contentColor: _isAudioEnabled ? Colors.green : Colors.red,
    );
  }

  void _toggleVideo() {
    _webrtcService.toggleVideo();
    setState(() {
      _isVideoEnabled = _webrtcService.isVideoEnabled;
    });
    
    BotToast.showText(
      text: _isVideoEnabled ? 'Video enabled' : 'Video disabled',
      textStyle: const TextStyle(color: Colors.white),
      contentColor: _isVideoEnabled ? Colors.green : Colors.red,
    );
  }

  Future<void> _switchCamera() async {
    await _webrtcService.switchCamera();
    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    
    BotToast.showText(
      text: 'Camera switched',
      textStyle: const TextStyle(color: Colors.white),
      contentColor: Colors.blue,
    );
  }

  void _endCall() {
    context.pop();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _webrtcService.dispose();
    _signalingService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Room: ${widget.roomId}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              BotToast.showText(
                text: widget.isCaller ? 'You are the caller' : 'You joined this call',
                textStyle: const TextStyle(color: Colors.white),
                contentColor: Colors.blue,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Remote video (full screen)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey[900],
                  child: _isConnected && _remoteRenderer.srcObject != null
                      ? RTCVideoView(_remoteRenderer, mirror: false)
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UserAvatar(
                                displayName: 'Remote User',
                                size: 120,
                                backgroundColor: Colors.grey[700],
                                textSize: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _isConnected 
                                    ? 'Remote user\'s camera is off'
                                    : 'Waiting for remote video...',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                // Local video (small overlay)
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _localRenderer.srcObject != null && _isVideoEnabled
                          ? RTCVideoView(_localRenderer, mirror: _isFrontCamera)
                          : Container(
                              color: Colors.grey[800],
                              child: Center(
                                child: UserAvatar(
                                  displayName: _currentUserName,
                                  photoURL: _currentUserPhoto,
                                  size: 60,
                                  backgroundColor: const Color(0xFF667eea),
                                  textSize: 24,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                // Connection status
                if (!_isConnected)
                  Positioned(
                    bottom: 100,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Card(
                        color: Colors.black.withValues(alpha: 0.7),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                widget.isCaller 
                                    ? 'Waiting for someone to join...' 
                                    : 'Connecting...',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Control buttons
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Audio toggle
                FloatingActionButton(
                  onPressed: _toggleAudio,
                  backgroundColor: _isAudioEnabled ? Colors.white : Colors.red,
                  foregroundColor: _isAudioEnabled ? Colors.black : Colors.white,
                  child: Icon(_isAudioEnabled ? Icons.mic : Icons.mic_off),
                ),
                // Video toggle
                FloatingActionButton(
                  onPressed: _toggleVideo,
                  backgroundColor: _isVideoEnabled ? Colors.white : Colors.red,
                  foregroundColor: _isVideoEnabled ? Colors.black : Colors.white,
                  child: Icon(_isVideoEnabled ? Icons.videocam : Icons.videocam_off),
                ),
                // Switch camera
                FloatingActionButton(
                  onPressed: _switchCamera,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: const Icon(Icons.switch_camera),
                ),
                // End call
                FloatingActionButton(
                  onPressed: _endCall,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.call_end),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}