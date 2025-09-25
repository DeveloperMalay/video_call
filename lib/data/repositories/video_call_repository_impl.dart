import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/error/failures.dart';
import '../../core/services/chime_sdk_service.dart';
import '../../domain/repositories/video_call_repository.dart';

class VideoCallRepositoryImpl implements VideoCallRepository {
  VideoCallRepositoryImpl();

  @override
  Future<Either<Failure, void>> joinMeeting(String meetingId) async {
    try {
      // Initialize Chime SDK
      final initialized = await ChimeSDKService.initialize();
      if (!initialized) {
        return Left(VideoCallFailure());
      }

      // Create meeting session with demo values
      final sessionCreated = await ChimeSDKService.createMeetingSession(
        meetingId: meetingId,
        mediaRegion: 'us-east-1',
        attendeeId: 'attendee-${DateTime.now().millisecondsSinceEpoch}',
        externalUserId: 'user-${DateTime.now().millisecondsSinceEpoch}',
      );

      if (!sessionCreated) {
        return Left(VideoCallFailure());
      }

      // Start the meeting
      final meetingStarted = await ChimeSDKService.startMeeting();
      if (meetingStarted) {
        return const Right(null);
      } else {
        return Left(VideoCallFailure());
      }
    } catch (e) {
      return Left(VideoCallFailure());
    }
  }

  @override
  Future<Either<Failure, void>> leaveMeeting() async {
    try {
      final success = await ChimeSDKService.stopMeeting();
      if (success) {
        return const Right(null);
      } else {
        return Left(VideoCallFailure());
      }
    } catch (e) {
      return Left(VideoCallFailure());
    }
  }

  @override
  Future<Either<Failure, void>> muteAudio() async {
    try {
      final success = await ChimeSDKService.muteLocalAudio();
      if (success) {
        return const Right(null);
      } else {
        return Left(VideoCallFailure());
      }
    } catch (e) {
      return Left(VideoCallFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unmuteAudio() async {
    try {
      final success = await ChimeSDKService.unmuteLocalAudio();
      if (success) {
        return const Right(null);
      } else {
        return Left(VideoCallFailure());
      }
    } catch (e) {
      return Left(VideoCallFailure());
    }
  }

  @override
  Future<Either<Failure, void>> enableVideo() async {
    try {
      final success = await ChimeSDKService.startLocalVideo();
      if (success) {
        return const Right(null);
      } else {
        return Left(VideoCallFailure());
      }
    } catch (e) {
      return Left(VideoCallFailure());
    }
  }

  @override
  Future<Either<Failure, void>> disableVideo() async {
    try {
      final success = await ChimeSDKService.stopLocalVideo();
      if (success) {
        return const Right(null);
      } else {
        return Left(VideoCallFailure());
      }
    } catch (e) {
      return Left(VideoCallFailure());
    }
  }

  @override
  Future<Either<Failure, void>> requestPermissions() async {
    try {
      final cameraStatus = await Permission.camera.request();
      final microphoneStatus = await Permission.microphone.request();

      if (cameraStatus.isGranted && microphoneStatus.isGranted) {
        return const Right(null);
      } else {
        return Left(PermissionFailure());
      }
    } catch (e) {
      return Left(PermissionFailure());
    }
  }
}