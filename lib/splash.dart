import 'package:bitmap_flutter/main.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    // 화면이 시작되고 몇 초간의 딜레이 후 다음 화면으로 넘어가는 부분
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (BuildContext context) => MyApp()),
            (route) => false));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // body: Container(
        //   alignment: Alignment.center,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       SizedBox(
        //           width: 500,
        //           height: 500,
        //           child: Lottie.asset('assets/lottie/bitmapIntro.json',
        //               controller: _controller, onLoaded: (composition) {
        //             _controller.addStatusListener((status) {
        //               if (status == AnimationStatus.dismissed)
        //                 _controller.forward();
        //               else if (status == AnimationStatus.completed)
        //                 _controller.reverse();
        //             });
        //             _controller
        //               ..duration = composition.duration
        //               ..forward();
        //           }))
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
