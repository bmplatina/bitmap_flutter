import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class FirebaseBmp {
  FirebaseBmp._privateConstructor();
  static final FirebaseBmp _instance = FirebaseBmp._privateConstructor();

  factory FirebaseBmp() {
    return _instance;
  }

  Stream getAuthStateChanged() {
    return FirebaseAuth.instance.authStateChanges();
  }
}