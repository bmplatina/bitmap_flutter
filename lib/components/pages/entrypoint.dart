import 'dart:math';
import 'package:bitmap_flutter/components/pages/Website.dart';
import 'package:bitmap_flutter/components/sidebars/sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/Firebase.dart';
import 'auth.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {
  // Sidebar Animations
  bool isSidebarOpened = false, isLoggedIn = false;
  late AnimationController _animationController;
  late Animation<double> animation;

  // Firebase Auth Info
  final FirebaseBmp _bmpFirebase = FirebaseBmp.instance;
  final _idTextEditCtl = TextEditingController(); // Use _idTextEditCtl.text to get value
  final _pwTextEditCtl = TextEditingController(); // Use _pwTextEditCtl.text to get value

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, 
        duration: Duration(milliseconds: 200)
    )..addListener(() {
      setState(() { });
    });

    _bmpFirebase.getAuth().authStateChanges().listen((User? user) {
      setState(() {
        isLoggedIn = _bmpFirebase.isLoggedIn();
      });
    });

    animation = Tween<double>(begin: 0, end: 1)
      .animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    _idTextEditCtl.dispose();
    _pwTextEditCtl.dispose();
    super.dispose();
  }

  // Custom Functions
  double map(double val, double oldMin, double oldMax, double newMin, double newMax) {  // map a value in new range
    return (((val - oldMin) * (newMax - newMin)) / (oldMax - oldMin) + newMin);
  }

  _showDismissableAlert(BuildContext context, String title, String content) {
    showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget> [
        CupertinoDialogAction(child: Text('Dismiss'), onPressed: () {Navigator.of(context).pop();},)
      ],
    ));
  }

  _showLoginDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Login to Bitmap'),
        content: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text('Login to Bitmap and enjoy our services.')
            ),
            CupertinoTextField(
              controller: _idTextEditCtl,
              placeholder: 'Email',
              onChanged: (text) {
                setState(() {

                });
              },
            ),
            CupertinoTextField(
              controller: _pwTextEditCtl,
              placeholder: 'Password',
              obscureText: true,
              onChanged: (text) {
                setState(() {

                });
              },
            )
          ],
        ),
        actions: <Widget> [
          CupertinoDialogAction(
            child: Text('Login'),
            onPressed: () async {
              try {
                UserCredential _credential = await _bmpFirebase.getAuth().signInWithEmailAndPassword(email: _idTextEditCtl.text, password: _pwTextEditCtl.text);
                if(_credential.user != null) {
                  Navigator.of(context).pop();
                } else {
                  _showDismissableAlert(context, 'Login Failed', 'Cannot login to Bitmap. It would be internal server error.');
                }
              } on FirebaseAuthException catch (error) {
                authErrorDialog(error);
              }
            }
          ),
          CupertinoDialogAction(
              child: Text('Sign-up'),
              onPressed: () async {
                try {
                  UserCredential _credential = await _bmpFirebase.getAuth().createUserWithEmailAndPassword(email: _idTextEditCtl.text, password: _pwTextEditCtl.text);
                  if(_credential.user != null) {
                    // isLoggedIn = true;
                    Navigator.of(context).pop();
                  } else {
                    _showDismissableAlert(context, 'Register Failed', 'Cannot login to Bitmap. It would be internal server error.');
                  }
                } on FirebaseAuthException catch (error) {
                  authErrorDialog(error);
                }
              }
          ),
          CupertinoDialogAction(
              child: Text('Cancel', style: TextStyle(color: CupertinoColors.destructiveRed)),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
        ],
      )
    );
  }

  _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to sign out, ${_bmpFirebase.getDisplayName()}?'),
          actions: <Widget> [
            CupertinoDialogAction(
                child: Text('Cancel', style: TextStyle(color: CupertinoColors.destructiveRed)),
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
            CupertinoDialogAction(
                child: Text('Logout'),
                onPressed: () {
                  _bmpFirebase.getAuth().signOut();
                  Navigator.of(context).pop();
                }
            ),
          ],
        )
    );
  }

  authErrorDialog(FirebaseAuthException error) {
    switch(error.code) {
        case 'invalid-email':
          _showDismissableAlert(context, 'Invalid Email', 'Email address that you typed is invalid. Please check your Email address.\nError Code: ${error.code}');
          break;
        case 'user-disabled':
          _showDismissableAlert(context, 'Your account is disabled', 'Your account is disabled. Please contact to service provider.\nError Code: ${error.code}');
          break;
        case "user-not-found":
          _showDismissableAlert(context, 'Incorrect Email', 'We can\'t find your account. Please sign up first.\nError Code: ${error.code}');
          break;
        case "wrong-password":
          _showDismissableAlert(context, 'Wrong password', 'You typed wrong password. Please check your password.\nError Code: ${error.code}');
          break;
      }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        // const Locale('ko', 'KR'),
      ],
      home: CupertinoPageScaffold(
        backgroundColor: Color(0xFF17203A),
        navigationBar: CupertinoNavigationBar(
          middle: Text('Bitmap'),
          trailing: CupertinoButton(
            child: isLoggedIn ? Icon(CupertinoIcons.arrow_right_square_fill): Icon(CupertinoIcons.arrow_right_square),
            onPressed: () {
              setState(() { });
              isLoggedIn ? _showLogoutDialog(context) : _showLoginDialog(context);
              // Auth(authMethods: isLoggedIn ? 'logout' : 'login');
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
