import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/SideMenuElements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/Firebase.dart';
import 'infocard.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  SideMenuIcons selectedMenu = sideMenuMain.first;
  FirebaseBmp bmpAuth = FirebaseBmp.instance;

  // Widget _InfoCard() {
  //   setState(() {
  //
  //   });
  //   if (bmpAuth
  //       .getDisplayName() != null
  //       && bmpAuth.getEmail() != null)
  //     return InfoCard(name: '${bmpAuth.getDisplayName()}',
  //         email: '${bmpAuth.getEmail()}');
  //   else
  //     return InfoCard(name: 'Login First', email: '');
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 288,
            height: double.infinity,
            color: Color(0xFF17203A), // Sidebar Color
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // StreamBuilder(
                  //   stream: FirebaseAuth.instance.authStateChanges(),
                  //   builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  //     if(snapshot.hasData) return InfoCard(name: snapshot.data.displayName, email: snapshot.data.email)
                  //     else return InfoCard(name: '이재혁', email: 'kkgordon.com@gmail.com')
                  //   }
                  // ),
                  InfoCard(name: '${bmpAuth.getDisplayName()}', email: '${bmpAuth.getEmail()}'),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                    child: Text(
                      'Browse'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: CupertinoColors.systemGrey6),
                    ),
                  ),
                  ...sideMenuMain.map((menu) => SideMenuInteractables(
                        menu: menu,
                        press: () {
                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                        isActive: selectedMenu == menu,
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                    child: Text(
                      'Store'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: CupertinoColors.systemGrey6),
                    ),
                  ),
                  ...sideMenuStore.map((menu) => SideMenuInteractables(
                        menu: menu,
                        press: () {
                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                        isActive: selectedMenu == menu,
                  )),
                ],
              ),
            )));
  }
}

class SideMenuInteractables extends StatelessWidget {
  const SideMenuInteractables(
      {
        super.key,
        required this.menu,
        required this.press,
        // required this.onInit,
        required this.isActive
      }
  );

  final SideMenuIcons menu;
  final VoidCallback press;
  // final ValueChanged<Artboard> onInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.all(0),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 47,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                  decoration: const BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: Icon(
                  menu.src,
                  color: CupertinoColors.white,
                ),
                // child: RiveAnimation.asset(
                //   'assets/rive/animated-icon-set.riv',
                //   artboard: 'HOME',
                //   onInit: (artboard) {},
                // ),
              ),
              title: Text(
                menu.title,
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
