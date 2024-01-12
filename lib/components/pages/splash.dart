import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'entrypoint.dart';
import '../sidebars/sidemenu.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void navigateToWidget(BuildContext context, Widget destinationWidget) { // 위젯이 로드되면 바로 이동
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute(builder: (BuildContext context) => destinationWidget), // 이동할 새 페이지
    (route) => false // 이전 모든 경로를 제거하기 위한 조건 함수
  );
}

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // 화면이 시작되고 몇초간의 딜레이 후, 다음 화면으로 넘어가는 부분
    new Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (BuildContext context) => EntryPoint()), // Init Page
                (route) => false));

    // SideBar() 페이지의 로딩이 완료되면 navigateToSideBar 호출
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   navigateToWidget(context, SideBar());
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // 크기 지정
                  width: 500,
                  height: 500,
                  // 내가 저장한 lottie 에셋 지정
                  child: Stack(
                    children: [
                      Container(color: CupertinoColors.systemPink, width: double.infinity, height: double.infinity,),
                      Lottie.asset('assets/lottie/BitmapBaseIntro.json',
                        controller: _controller, onLoaded: (composition) {
                          _controller.addStatusListener((status) {
                            if (status == AnimationStatus.dismissed) // 애니메이션이 사라지면 다시 생성
                              _controller.forward();
                            else if (status == AnimationStatus.completed) // 애니메이션이 끝나면 반대로 재생
                              _controller.reverse();
                          });
                          // Configure the AnimationController with the duration of the
                          // Lottie file and start the animation.
                          _controller
                          ..duration = composition.duration
                          ..forward();
                        }),
                    ]
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 안도ㅐ 이것만큼은 ㅠㅠ  야 너 머싯는거 하네 망치고싶게~~~