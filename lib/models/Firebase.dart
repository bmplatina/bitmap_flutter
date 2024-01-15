import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FirebaseBmp {
  // 정적 멤버 변수: 클래스 인스턴스를 저장하기 위한 변수
  static FirebaseBmp? _instance;

  // private 생성자: 외부에서 인스턴스를 직접 생성하지 못하게 함
  FirebaseBmp._();

  // 싱글톤 클래스의 인스턴스를 반환하는 정적 메서드
  static FirebaseBmp get instance {
    // 인스턴스가 없다면 생성, 이미 있다면 기존 인스턴스 반환
    _instance ??= FirebaseBmp._();
    return _instance!;
  }

  // 싱글톤 인스턴스 얻기
  // FirebaseBmp bmpFirebase = FirebaseBmp.instance;

  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  // Firebase Realtime Database
  final String _url = 'https://bitmap-esd-default-rtdb.asia-southeast1.firebasedatabase.app';
  // Firestore Database
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Methods
  FirebaseAuth getAuth() {
    return _auth;
  }

  // User
  User getCurrentUser() {
    return _auth.currentUser!;
  }

  // Auth
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }


  // User Info
  String? getDisplayName() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.displayName != null) {
      return currentUser.displayName;
    } else {
      return 'Login First'; // 사용자가 로그인되어 있지 않거나 Display Name이 없는 경우 null 반환
    }
  }
  String? getEmail() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.email != null) {
      return currentUser.email;
    } else {
      return ''; // 사용자가 로그인되어 있지 않거나 Display Name이 없는 경우 null 반환
    }
  }

  // Realtime Database
  /* firebasePost() async {
    await http.post(Uri.parse(_url), body: jsonEncode(data));
  }

  firebaseGet() async {
    await http.get(Uri.parse(_url)).then((value) => {
      if(jsonDecode(value.body) != null)
    });
  } */
}