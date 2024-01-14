// Flutter
import 'package:bitmap_flutter/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
// Components
import 'components/pages/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isApple() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.iOS:
          return true;
        case TargetPlatform.macOS:
          return true;
        default:
          return false;
      }
    }

    return CupertinoApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        // const Locale('ko', 'KR'),
      ],
      title: 'Bitmap',
      home: Splash(),
    );
  }
}
