import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/repositories/video_call_repository.dart';
import '../../../domain/usecases/join_meeting.dart';

part 'video_call_state.dart';
part 'video_call_cubit.freezed.dart';

class VideoCallCubit extends Cubit<VideoCallState> {
  final JoinMeeting _joinMeeting;
  final VideoCallRepository _videoCallRepository;

  bool _isAudioMuted = false;
  bool _isVideoEnabled = true;

  VideoCallCubit({
    required JoinMeeting joinMeeting,
    required VideoCallRepository videoCallRepository,
  })  : _joinMeeting = joinMeeting,
        _videoCallRepository = videoCallRepository,
        super(const VideoCallState.initial());

  Future<void> requestPermissions() async {
    final result = await _videoCallRepository.requestPermissions();
    result.fold(
      (failure) => emit(const VideoCallState.error('Permission denied')),
      (_) => {},
    );
  }

  Future<void> joinMeeting(String meetingId) async {
    emit(const VideoCallState.connecting());

    final failureOrSuccess = await _joinMeeting(JoinMeetingParams(meetingId: meetingId));

    failureOrSuccess.fold(
      (failure) => emit(const VideoCallState.error('Failed to join meeting')),
      (_) => emit(VideoCallState.connected(meetingId)),
    );
  }

  Future<void> leaveMeeting() async {
    final result = await _videoCallRepository.leaveMeeting();
    result.fold(
      (failure) => emit(const VideoCallState.error('Failed to leave meeting')),
      (_) => emit(const VideoCallState.disconnected()),
    );
  }

  Future<void> toggleAudio() async {
    final result = _isAudioMuted
        ? await _videoCallRepository.unmuteAudio()
        : await _videoCallRepository.muteAudio();

    result.fold(
      (failure) => emit(const VideoCallState.error('Failed to toggle audio')),
      (_) {
        _isAudioMuted = !_isAudioMuted;
        emit(VideoCallState.audioMuted(_isAudioMuted));
      },
    );
  }

  Future<void> toggleVideo() async {
    final result = _isVideoEnabled
        ? await _videoCallRepository.disableVideo()
        : await _videoCallRepository.enableVideo();

    result.fold(
      (failure) => emit(const VideoCallState.error('Failed to toggle video')),
      (_) {
        _isVideoEnabled = !_isVideoEnabled;
        emit(VideoCallState.videoEnabled(_isVideoEnabled));
      },
    );
  }

  bool get isAudioMuted => _isAudioMuted;
  bool get isVideoEnabled => _isVideoEnabled;
}