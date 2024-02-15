import 'package:flutter/material.dart';
import 'package:mission_3/controllers/speech_text.dart';
import 'package:mission_3/main.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class WriteSpeech extends StatefulWidget {
  final String? bodyMessage;
  final String? title;
  const WriteSpeech({super.key, this.bodyMessage, this.title});

  @override
  _WriteSpeechState createState() => _WriteSpeechState();
}

class _WriteSpeechState extends State<WriteSpeech> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    _text = "";
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('onStatus: $status');
        },
        onError: (error) {
          print('onError: $error');
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
            });
          },
        );
      }
    }
  }

  void _stopListening(BuildContext context) {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
    if (_text == 'repita a última mensagem') {
      SpeechText().speak(widget.bodyMessage != ''
          ? "A última mensagem foi de ${widget.title} e dizia ${widget.bodyMessage}"
          : "Não há mensagem ainda.");
    } else {
      SpeechText().speak(
          "Comando não reconhecido. Você precisa dizer: repita a última mensagem");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 0.0),
        child: ElevatedButton(
          onPressed: () {
            _isListening ? _stopListening(context) : _startListening();
          },
          child: Icon(_isListening ? Icons.stop : Icons.mic),
        ),
      ),
      Text(_text == ''
          ? "Você ainda não me disse nada."
          : "Você falou: ${_text}"),
    ]);
  }
}
