import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

class AlarmService {
  AlarmService._();

  static final AlarmService instance = AlarmService._();

  final AudioPlayer _player = AudioPlayer();

  Future<void> initialize() async {
    await _player.setAsset(
      'assets/sounds/alarm.mp3',
    );

    _player.setLoopMode(
      LoopMode.one,
    );
  }
  Future<void> play() async {
    try {
      debugPrint("========== PLAY ==========");

      await _player.seek(Duration.zero);
      await _player.play();

      debugPrint("========== STARTED ==========");
    } catch (e, st) {
      debugPrint("========== ERROR ==========");
      debugPrint(e.toString());
      debugPrint(st.toString());
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }

  
}