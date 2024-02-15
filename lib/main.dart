import 'package:flutter/material.dart';
import 'package:mission_3/controllers/write_speech.dart';
import 'package:mission_3/screens/home_screen.dart';
import 'package:mission_3/controllers/speech_text.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppState(),
      ),
    ],
    child: MyApp(),
  ));
}

class AppState extends ChangeNotifier {
  String _bodyMessage = "";

  String get bodyMessage => _bodyMessage;

  set bodyMessage(String newValue) {
    _bodyMessage = newValue;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpeechText speechText = SpeechText();

  String bodyMessage = "";
  String title = "";

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received: ${message.notification!.title}");
      print("Message body: ${message.notification!.body}");
      speakMessage(message.notification!.body!, message.notification!.title!);
      setState(() {
        bodyMessage = message.notification!.body!;
        title = message.notification!.title!;
      });
    });
  }

  void speakMessage(String message, String title) async {
    SpeechText speechText = SpeechText();
    await speechText.speak("A mensagem do $title foi $message");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doma',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: SafeArea(
          child: HomeScreen(
        bodyMessage: bodyMessage,
        title: title,
      )),
    );
  }
}
