import 'package:flutter/material.dart';
import 'package:mission_3/controllers/speech_text.dart';
import 'package:mission_3/controllers/write_speech.dart';

import 'package:provider/provider.dart';
import 'package:mission_3/main.dart';

class HomeScreen extends StatefulWidget {
  final String? bodyMessage;
  final String? title;

  const HomeScreen({super.key, this.bodyMessage, this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SpeechText speechText = SpeechText();
  WriteSpeech writeSpeech = WriteSpeech();

  @override
  Widget build(BuildContext context) {
    // String bodyMessage = Provider.of<AppState>(context).bodyMessage;

    return Scaffold(
        appBar: AppBar(
          title: const Text("DOMA APP"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: WriteSpeech(
                    bodyMessage: widget.bodyMessage,
                    title: widget.title,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0.0),
                      backgroundColor: Colors.blue[400]),
                  child: Text("Aperte para falar",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () async {
                    await speechText
                        .speak("A menssagem foi: ${widget.bodyMessage}");
                  },
                ), // Text("$bodyMessage")
              ]),
        ));
  }
}
