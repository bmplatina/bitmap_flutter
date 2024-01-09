import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'infocard.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 288,
            height: double.infinity,
            color: Color(0xFF17203A),
            child: SafeArea(
              child: Column(
                children: [
                  InfoCard(name: 'Platina', email: 'kkgordon.com@gmail.com'),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Divider(
                          color: Colors.white24,
                          height: 1,
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: SizedBox(
                          height: 34,
                          width: 34,
                          child: RiveAnimation.asset(
                            'assets/rive/animated-icon-set.riv',
                            artboard: 'HOME',
                            onInit: (artboard) {},
                          ),
                        ),
                        title: Text(
                          'Wiki',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
