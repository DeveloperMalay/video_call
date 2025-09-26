import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../core/services/firebase_webrtc_service.dart';
import '../../core/config/app_router.dart';

class FirebaseVideoCallPage extends StatefulWidget {
  final String? roomId;
  final bool isCaller;
  final String? callerName;

  const FirebaseVideoCallPage({
    super.key,
    this.roomId,
    required this.isCaller,
    this.callerName,
  });

  @override
  State<FirebaseVideoCallPage> createState() => _FirebaseVideoCallPageState();
}

class _FirebaseVideoCallPageState extends State<FirebaseVideoCallPage> {
  final FirebaseWebRTCService _webrtcService = FirebaseWebRTCService();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  
  String _callStatus = 'Initializing...';
  bool _isAudioEnabled = true;
  bool _isVideoEnabled = true;
  bool _isConnected = false;
  String? _currentCallId;

  @override
  void initState() {
    super.initState();
    _initializeRenderers();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    
    // Listen to streams
    _webrtcService.localStream.listen((stream) {
      if (stream != null && mounted) {
        _localRenderer.srcObject = stream;
        setState(() {});
      }
    });
    
    _webrtcService.remoteStream.listen((stream) {
      if (stream != null && mounted) {
        _remoteRenderer.srcObject = stream;
        setState(() {
          _isConnected = true;
        });
      }
    });
    
    _webrtcService.callState.listen((status) {
      if (mounted) {
        setState(() {
          _callStatus = status;
        });
        
        // Auto-navigate to home screen when call ends or disconnects
        if (status == 'Call ended' || status == 'Disconnected' || status == 'Connection failed') {
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              context.go(AppRouter.users);
              BotToast.showText(
                text: status == 'Call ended' ? 'Call ended' : 'Call disconnected',
                textStyle: const TextStyle(color: Colors.white),
                contentColor: Colors.red,
              );
            }
          });
        }
      }
    });

    await _initializeCall();
  }

  Future<void> _initializeCall() async {
    try {
      await _webrtcService.initializeLocalMedia();
      
      if (widget.isCaller) {
        final callId = await _webrtcService.createCall();
        setState(() {
          _currentCallId = callId;
        });
        _showCallIdDialog(callId);
      } else if (widget.roomId != null) {
        await _webrtcService.joinCall(widget.roomId!);
        setState(() {
          _currentCallId = widget.roomId;
        });
      }
    } catch (e) {
      BotToast.showText(
        text: 'Error: $e',
        textStyle: const TextStyle(color: Colors.white),
        contentColor: Colors.red,
      );
      
      // Navigate back to home on error after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          context.go(AppRouter.users);
        }
      });
    }
  }

  void _showCallIdDialog(String callId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Call Created'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Share this Call ID with others:'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  callId,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Others can join using this Call ID',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: callId));
                Navigator.of(context).pop();
                BotToast.showText(
                  text: 'Call ID copied to clipboard!',
                  textStyle: const TextStyle(color: Colors.white),
                  contentColor: Colors.green,
                );
              },
              child: const Text('Copy & Close'),
            ),
          ],
        );
      },
    );
  }

  void _toggleAudio() {
    _webrtcService.toggleAudio();
    setState(() {
      _isAudioEnabled = _webrtcService.isAudioEnabled;
    });
    
    BotToast.showText(
      text: _isAudioEnabled ? 'Audio enabled' : 'Audio muted',
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
    BotToast.showText(
      text: 'Camera switched',
      textStyle: const TextStyle(color: Colors.white),
      contentColor: Colors.blue,
    );
  }

  Future<void> _endCall() async {
    await _webrtcService.endCall();
    if (mounted) {
      // Navigate back to users page (home screen) instead of just going back one level
      context.go(AppRouter.users);
      BotToast.showText(
        text: 'Call ended',
        textStyle: const TextStyle(color: Colors.white),
        contentColor: Colors.red,
      );
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _webrtcService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.callerName ?? 'Video Call',
              style: const TextStyle(fontSize: 18),
            ),
            if (_currentCallId != null)
              Text(
                'ID: ${_currentCallId!.substring(0, 8)}...',
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
          ],
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              if (_currentCallId != null) {
                _showCallIdDialog(_currentCallId!);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Area
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              child: Stack(
                children: [
                  // Remote video (full screen)
                  if (_isConnected && _remoteRenderer.srcObject != null)
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: RTCVideoView(
                        _remoteRenderer,
                        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        mirror: false,
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey[900],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _callStatus.contains('not found') || _callStatus.contains('Error') || _callStatus.contains('Failed')
                                ? Icons.error_outline
                                : _isConnected ? Icons.person : Icons.videocam_off,
                            size: 120,
                            color: _callStatus.contains('not found') || _callStatus.contains('Error') || _callStatus.contains('Failed')
                                ? Colors.red
                                : Colors.white54,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _callStatus,
                            style: TextStyle(
                              color: _callStatus.contains('not found') || _callStatus.contains('Error') || _callStatus.contains('Failed')
                                  ? Colors.red
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (widget.isCaller && !_isConnected) ...[
                            const SizedBox(height: 16),
                            Text(
                              _currentCallId != null 
                                  ? 'Call ID: ${_currentCallId!.substring(0, 8)}...'
                                  : 'Creating call...',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  
                  // Local video (small overlay)
                  Positioned(
                    top: 40,
                    right: 20,
                    width: 120,
                    height: 160,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _localRenderer.srcObject != null
                            ? RTCVideoView(
                                _localRenderer,
                                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                                mirror: true,
                              )
                            : Container(
                                color: Colors.grey[800],
                                child: const Center(
                                  child: Icon(
                                    Icons.videocam_off,
                                    color: Colors.white54,
                                    size: 40,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Control Buttons
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            color: Colors.black,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Audio toggle
                  FloatingActionButton(
                    onPressed: _toggleAudio,
                    backgroundColor: _isAudioEnabled ? Colors.white : Colors.red,
                    foregroundColor: _isAudioEnabled ? Colors.black : Colors.white,
                    heroTag: "audio",
                    child: Icon(_isAudioEnabled ? Icons.mic : Icons.mic_off),
                  ),
                  
                  // Video toggle
                  FloatingActionButton(
                    onPressed: _toggleVideo,
                    backgroundColor: _isVideoEnabled ? Colors.white : Colors.red,
                    foregroundColor: _isVideoEnabled ? Colors.black : Colors.white,
                    heroTag: "video",
                    child: Icon(_isVideoEnabled ? Icons.videocam : Icons.videocam_off),
                  ),
                  
                  // Switch camera
                  FloatingActionButton(
                    onPressed: _switchCamera,
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    heroTag: "camera",
                    child: const Icon(Icons.switch_camera),
                  ),
                  
                  // End call
                  FloatingActionButton(
                    onPressed: _endCall,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    heroTag: "endCall",
                    child: const Icon(Icons.call_end),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}