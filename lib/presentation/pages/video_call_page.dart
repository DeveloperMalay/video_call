import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../injection_container.dart';
import '../cubit/video_call/video_call_cubit.dart';
import '../widgets/video_call_controls.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late VideoCallCubit _cubit;
  late String _meetingId;
  late String _inviteLink;

  @override
  void initState() {
    super.initState();
    _meetingId = _generateMeetingId();
    _inviteLink = _generateInviteLink(_meetingId);
    _cubit = VideoCallCubit(
      joinMeeting: sl(),
      videoCallRepository: sl(),
    );
    _requestPermissionsAndJoin();
  }

  String _generateMeetingId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'meeting-$timestamp';
  }

  String _generateInviteLink(String meetingId) {
    return 'videocall://join?meeting=$meetingId';
  }

  void _requestPermissionsAndJoin() async {
    await _cubit.requestPermissions();
    await _cubit.joinMeeting(_meetingId);
  }

  void _copyInviteLink() {
    Clipboard.setData(ClipboardData(text: _inviteLink));
    BotToast.showText(
      text: 'Invite link copied to clipboard!',
      textStyle: const TextStyle(color: Colors.white),
      contentColor: Colors.green,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Video Call'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _copyInviteLink,
            tooltip: 'Invite someone',
          ),
        ],
      ),
      body: BlocProvider.value(
        value: _cubit,
        child: BlocListener<VideoCallCubit, VideoCallState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
          child: BlocBuilder<VideoCallCubit, VideoCallState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey.shade800,
                            Colors.grey.shade900,
                          ],
                        ),
                      ),
                      child: state.when(
                        initial: () => const Center(
                          child: Text(
                            'Initializing...',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        connecting: () => const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 16),
                              Text(
                                'Connecting to meeting...',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        connected: (meetingId) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.videocam,
                                  size: 120,
                                  color: Colors.white54,
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Video Call Active',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Meeting ID: $_meetingId',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Invite Link',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          _inviteLink,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            fontFamily: 'monospace',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ElevatedButton.icon(
                                        onPressed: _copyInviteLink,
                                        icon: const Icon(Icons.copy),
                                        label: const Text('Copy Invite Link'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF667eea),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Local and remote video streams would appear here',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        disconnected: () => const Center(
                          child: Text(
                            'Call Ended',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        error: (message) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                message,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        audioMuted: (_) => const Center(
                          child: Text(
                            'Audio Updated',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        videoEnabled: (_) => const Center(
                          child: Text(
                            'Video Updated',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VideoCallControls(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.leaveMeeting();
    super.dispose();
  }
}