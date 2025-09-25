import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
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

  @override
  void initState() {
    super.initState();
    _cubit = VideoCallCubit(
      joinMeeting: sl(),
      videoCallRepository: sl(),
    );
    _requestPermissionsAndJoin();
  }

  void _requestPermissionsAndJoin() async {
    await _cubit.requestPermissions();
    await _cubit.joinMeeting(AppConstants.defaultMeetingId);
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
                        connected: (meetingId) => const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.videocam,
                                size: 120,
                                color: Colors.white54,
                              ),
                              SizedBox(height: 24),
                              Text(
                                'Video Call Active',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Local and remote video streams would appear here',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
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