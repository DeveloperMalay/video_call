import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/video_call/video_call_cubit.dart';

class VideoCallControls extends StatelessWidget {
  const VideoCallControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BlocBuilder<VideoCallCubit, VideoCallState>(
        builder: (context, state) {
          final cubit = context.read<VideoCallCubit>();
          
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ControlButton(
                icon: cubit.isAudioMuted ? Icons.mic_off : Icons.mic,
                isActive: !cubit.isAudioMuted,
                onPressed: () => cubit.toggleAudio(),
                tooltip: cubit.isAudioMuted ? 'Unmute' : 'Mute',
              ),
              _ControlButton(
                icon: cubit.isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                isActive: cubit.isVideoEnabled,
                onPressed: () => cubit.toggleVideo(),
                tooltip: cubit.isVideoEnabled ? 'Turn Off Video' : 'Turn On Video',
              ),
              _ControlButton(
                icon: Icons.screen_share,
                isActive: false,
                onPressed: () {
                  // Screen share functionality would be implemented here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Screen share feature would be implemented here'),
                    ),
                  );
                },
                tooltip: 'Share Screen',
              ),
              _ControlButton(
                icon: Icons.call_end,
                isActive: false,
                backgroundColor: Colors.red,
                onPressed: () {
                  cubit.leaveMeeting();
                  context.pop();
                },
                tooltip: 'End Call',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;
  final String tooltip;
  final Color? backgroundColor;

  const _ControlButton({
    required this.icon,
    required this.isActive,
    required this.onPressed,
    required this.tooltip,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: backgroundColor ?? (isActive ? Colors.white : Colors.grey.shade600),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: backgroundColor != null 
                ? Colors.white 
                : (isActive ? Colors.black : Colors.white),
            size: 24,
          ),
        ),
      ),
    );
  }
}