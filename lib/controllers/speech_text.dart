import 'package:flutter_tts/flutter_tts.dart';

class SpeechText {
  final FlutterTts flutterTts = FlutterTts();

  void speakMessage(String message) async {
    SpeechText speechText = SpeechText();
    await speechText.speak("A mensagem foi: $message");
  }

  Future<void> speak(param) async {
    try {
      await flutterTts.setLanguage("pt-BR");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak("${param}");
    } catch (e) {
      print("Erro ao falar a hora: ${e}");
    }
  }
}
