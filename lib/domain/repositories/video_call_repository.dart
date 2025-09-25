import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

abstract class VideoCallRepository {
  Future<Either<Failure, void>> joinMeeting(String meetingId);
  Future<Either<Failure, void>> leaveMeeting();
  Future<Either<Failure, void>> muteAudio();
  Future<Either<Failure, void>> unmuteAudio();
  Future<Either<Failure, void>> enableVideo();
  Future<Either<Failure, void>> disableVideo();
  Future<Either<Failure, void>> requestPermissions();
}