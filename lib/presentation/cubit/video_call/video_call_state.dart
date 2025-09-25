part of 'video_call_cubit.dart';

@freezed
class VideoCallState with _$VideoCallState {
  const factory VideoCallState.initial() = _Initial;
  const factory VideoCallState.connecting() = _Connecting;
  const factory VideoCallState.connected(String meetingId) = _Connected;
  const factory VideoCallState.disconnected() = _Disconnected;
  const factory VideoCallState.error(String message) = _Error;
  const factory VideoCallState.audioMuted(bool isMuted) = _AudioMuted;
  const factory VideoCallState.videoEnabled(bool isEnabled) = _VideoEnabled;
}