import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../repositories/video_call_repository.dart';
import 'usecase.dart';

class JoinMeeting implements UseCase<void, JoinMeetingParams> {
  final VideoCallRepository repository;

  JoinMeeting(this.repository);

  @override
  Future<Either<Failure, void>> call(JoinMeetingParams params) async {
    return await repository.joinMeeting(params.meetingId);
  }
}

class JoinMeetingParams extends Equatable {
  final String meetingId;

  const JoinMeetingParams({required this.meetingId});

  @override
  List<Object> get props => [meetingId];
}