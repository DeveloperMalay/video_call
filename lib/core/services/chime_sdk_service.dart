import 'package:flutter/services.dart';

class ChimeSDKService {
  static const MethodChannel _channel = MethodChannel('amazon_chime_sdk');
  static const EventChannel _eventChannel = EventChannel('amazon_chime_sdk_events');

  static Stream<Map<String, dynamic>>? _eventStream;

  static Stream<Map<String, dynamic>> get eventStream {
    _eventStream ??= _eventChannel.receiveBroadcastStream().map(
      (event) => Map<String, dynamic>.from(event),
    );
    return _eventStream!;
  }

  static Future<bool> initialize() async {
    try {
      final result = await _channel.invokeMethod('initialize');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to initialize Chime SDK: ${e.message}');
      return false;
    }
  }

  static Future<bool> createMeetingSession({
    required String meetingId,
    required String mediaRegion,
    required String attendeeId,
    required String externalUserId,
  }) async {
    try {
      final result = await _channel.invokeMethod('createMeetingSession', {
        'meetingId': meetingId,
        'mediaRegion': mediaRegion,
        'attendeeId': attendeeId,
        'externalUserId': externalUserId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to create meeting session: ${e.message}');
      return false;
    }
  }

  static Future<bool> startMeeting() async {
    try {
      final result = await _channel.invokeMethod('startMeeting');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to start meeting: ${e.message}');
      return false;
    }
  }

  static Future<bool> stopMeeting() async {
    try {
      final result = await _channel.invokeMethod('stopMeeting');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to stop meeting: ${e.message}');
      return false;
    }
  }

  static Future<bool> muteLocalAudio() async {
    try {
      final result = await _channel.invokeMethod('muteLocalAudio');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to mute audio: ${e.message}');
      return false;
    }
  }

  static Future<bool> unmuteLocalAudio() async {
    try {
      final result = await _channel.invokeMethod('unmuteLocalAudio');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to unmute audio: ${e.message}');
      return false;
    }
  }

  static Future<bool> startLocalVideo() async {
    try {
      final result = await _channel.invokeMethod('startLocalVideo');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to start video: ${e.message}');
      return false;
    }
  }

  static Future<bool> stopLocalVideo() async {
    try {
      final result = await _channel.invokeMethod('stopLocalVideo');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to stop video: ${e.message}');
      return false;
    }
  }

  static Future<bool> switchCamera() async {
    try {
      final result = await _channel.invokeMethod('switchCamera');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to switch camera: ${e.message}');
      return false;
    }
  }

  static Future<List<String>> listAudioDevices() async {
    try {
      final result = await _channel.invokeMethod('listAudioDevices');
      return List<String>.from(result ?? []);
    } on PlatformException catch (e) {
      print('Failed to list audio devices: ${e.message}');
      return [];
    }
  }

  static Future<bool> chooseAudioDevice(String deviceId) async {
    try {
      final result = await _channel.invokeMethod('chooseAudioDevice', {
        'deviceId': deviceId,
      });
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to choose audio device: ${e.message}');
      return false;
    }
  }

  static Future<bool> startContentShare() async {
    try {
      final result = await _channel.invokeMethod('startContentShare');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to start content share: ${e.message}');
      return false;
    }
  }

  static Future<bool> stopContentShare() async {
    try {
      final result = await _channel.invokeMethod('stopContentShare');
      return result ?? false;
    } on PlatformException catch (e) {
      print('Failed to stop content share: ${e.message}');
      return false;
    }
  }
}