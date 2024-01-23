import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bitmap_flutter/models/Firebase.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key, required this.authMethods})
      : super(key: key);
  final String authMethods;

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  FirebaseBmp _bmpFirebase = FirebaseBmp.instance;
  final _idTextEditCtl = TextEditingController(); // Use _idTextEditCtl.text to get value
  final _pwTextEditCtl = TextEditingController(); // Use _pwTextEditCtl.text to get value

  _showDismissableAlert(BuildContext context, String title, String content) {
    return showCupertinoDialog(context: context, builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget> [
        CupertinoDialogAction(child: Text('Dismiss'), onPressed: () {Navigator.of(context).pop();},)
      ],
    ));
  }

  _showLoginDialog(BuildContext context) {
    return showCupertinoDialog(
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
    return showCupertinoDialog(
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
    print('Method: ${widget.authMethods}');
    switch(widget.authMethods) {
      case 'register':
        return CupertinoFormSection.insetGrouped(
            header: Text(''),
            children: [
              CupertinoTextFormFieldRow(
                prefix: Text('Email:'),
                placeholder: 'Enter Email address',
              ),
              CupertinoTextFormFieldRow(
                prefix: Text('Password:'),
                placeholder: 'Enter Password',
              ),
              CupertinoTextFormFieldRow(
                prefix: Text('Retype Password:'),
                placeholder: 'Enter Password again',
              )
            ]
        );
      case 'login':
        return _showLoginDialog(context);
      case 'logout':
        return _showLogoutDialog(context);
      default:
        return _showDismissableAlert(context, 'Bad arguments', '${widget.authMethods} is bad keyword.');
    }

  }
}

