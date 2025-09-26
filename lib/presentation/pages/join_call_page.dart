import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../core/config/app_router.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class JoinCallPage extends StatefulWidget {
  const JoinCallPage({super.key});

  @override
  State<JoinCallPage> createState() => _JoinCallPageState();
}

class _JoinCallPageState extends State<JoinCallPage> {
  final _roomIdController = TextEditingController();
  final _callerIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _roomIdController.dispose();
    _callerIdController.dispose();
    super.dispose();
  }

  String? _validateRoomId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Room ID';
    }
    return null;
  }

  String? _validateCallerId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Caller ID';
    }
    return null;
  }

  void _createCall() {
    if (_formKey.currentState!.validate()) {
      final roomId = _roomIdController.text.trim();
      final callerName = _callerIdController.text.trim();
      context.go('${AppRouter.webrtcCall}?roomId=$roomId&isCaller=true&callerName=${Uri.encodeComponent(callerName)}');
    }
  }

  void _joinCall() {
    if (_formKey.currentState!.validate()) {
      final roomId = _roomIdController.text.trim();
      final callerName = _callerIdController.text.trim();
      context.go('${AppRouter.webrtcCall}?roomId=$roomId&isCaller=false&callerName=${Uri.encodeComponent(callerName)}');
    }
  }

  void _generateRoomId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final roomId = 'room-$timestamp';
    _roomIdController.text = roomId;
    BotToast.showText(
      text: 'Room ID generated!',
      textStyle: const TextStyle(color: Colors.white),
      contentColor: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Video Call'),
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.video_call,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 24),
                const Text(
                  'WebRTC Video Call',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create or join a video call room',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _callerIdController,
                            label: 'Your Name',
                            keyboardType: TextInputType.text,
                            validator: _validateCallerId,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _roomIdController,
                                  label: 'Room ID',
                                  keyboardType: TextInputType.text,
                                  validator: _validateRoomId,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: _generateRoomId,
                                icon: const Icon(Icons.refresh),
                                tooltip: 'Generate Room ID',
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0xFF667eea),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  onPressed: _createCall,
                                  text: 'Create Call',
                                  isLoading: false,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomButton(
                                  onPressed: _joinCall,
                                  text: 'Join Call',
                                  isLoading: false,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Enter a room ID and create a new call or join an existing one',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}