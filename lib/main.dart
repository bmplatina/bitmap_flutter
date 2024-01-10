// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Components
import 'components/sidebars/sidemenu.dart';
import 'components/pages/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isApple() {
      switch (Theme.of(context).platform) {
        //TODO: Handle this case.
        case TargetPlatform.iOS:
          return true;
        case TargetPlatform.macOS:
          return true;
        default:
          return false;
      }
    }

    return CupertinoApp(
      title: 'Bitmap',
      home: Splash(),
    );
  }
}
