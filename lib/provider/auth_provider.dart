import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = true;
  bool get isLogin => _isLogin;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  setIsLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  setObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  signUp({required String email, required String password}) {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  signIn({required String email, required String password}) {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
