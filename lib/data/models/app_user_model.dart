import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_model.freezed.dart';
part 'app_user_model.g.dart';

@freezed
class AppUserModel with _$AppUserModel {
  const factory AppUserModel({
    required String uid,
    required String email,
    required String displayName,
    String? photoURL,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? lastSignIn,
    @TimestampConverter() DateTime? lastSeen,
    @Default(false) bool isOnline,
  }) = _AppUserModel;

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  factory AppUserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUserModel.fromJson({
      ...data,
      'uid': doc.id,
    });
  }
}

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    return null;
  }

  @override
  dynamic toJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}