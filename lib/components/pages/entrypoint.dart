import 'dart:math';
import 'package:bitmap_flutter/components/pages/Website.dart';
import 'package:bitmap_flutter/components/sidebars/sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {
  bool isSidebarOpened = false, isLoggedIn = false;
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this, 
        duration: Duration(milliseconds: 200)
    )..addListener(() {
      setState(() { });
    });

    animation = Tween<double>(begin: 0, end: 1)
      .animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  double map(double val, double oldMin, double oldMax, double newMin, double newMax) {
    return (((val - oldMin) * (newMax - newMin)) / (oldMax - oldMin) + newMin);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        backgroundColor: Color(0xFF17203A),
        navigationBar: CupertinoNavigationBar(
          middle: Text('Bitmap'),
          trailing: CupertinoButton(
            child: isLoggedIn ? Icon(CupertinoIcons.arrow_right_square): Icon(CupertinoIcons.arrow_right_square_fill),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Dialog Title'),
                    content: Text('Dialog Content'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              setState(() {
                isLoggedIn = !isLoggedIn;
              });
            },
          ),
          leading: CupertinoButton(
            child: Icon(CupertinoIcons.sidebar_left),
            onPressed: () {
              if(isSidebarOpened) {
                _animationController.reverse();
              }
              else {
                _animationController.forward();
              }
              setState(() {
                isSidebarOpened = !isSidebarOpened;
              });
            },
          ),
        ),
        child : Stack(children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: SideBar(),
            width: 288,
            left: isSidebarOpened ? 0: -288,
            height: MediaQuery.of(context).size.height,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * pi * animation.value / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0), // Offset(isSidebarOpened ? 288 : 0, 0),
              child: Transform.scale(
                scale: map(animation.value, 0.0, 1.0, 1.0, 0.8), // isSidebarOpened ? 0.8 : 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(animation.value * 24)),
                  child: Website()
                )
              ),
            ),
          )
        ])
      ),
    );
  }
}
