import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../models/Firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class InfoCard extends StatelessWidget {
//   const InfoCard({Key? key, required this.name, required this.email})
//       : super(key: key);
//
//
//   final String name, email;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: const CircleAvatar(
//         backgroundColor: Colors.white24,
//         child: Icon(
//           CupertinoIcons.person,
//           color: Colors.white,
//         ),
//       ),
//       title: Text(name, style: TextStyle(color: Colors.white)),
//       subtitle: Text(email, style: TextStyle(color: Colors.white)),
//     );
//   }
// }

class InfoCard extends StatefulWidget {
  const InfoCard({super.key});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  FirebaseBmp _bmpFirebase = FirebaseBmp.instance;
  bool isLoggedIn = false;
  String _name = '', _email = '';
  @override

  void initState() {
    _bmpFirebase.getAuth().authStateChanges().listen((User? user) {
      isLoggedIn = _bmpFirebase.isLoggedIn();
      _name = _bmpFirebase.getDisplayName()!;
      _email = _bmpFirebase.getEmail()!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(_name, style: TextStyle(color: Colors.white)),
      subtitle: Text(_email, style: TextStyle(color: Colors.white)),
    );
  }
}
