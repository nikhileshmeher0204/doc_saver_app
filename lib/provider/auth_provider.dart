import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:doc_saver_app/helper/snackbar_helper.dart';
import '../screens/home_screen.dart';

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
  setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  signUp(BuildContext context,
      {required String email, required String password}) async {
    try {
      setIsLoading(true);
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setIsLoading(false);
        SnackBarHelper.showErrorSnackBar(context, "Sign Up Successful");
        Navigator.of(context).pushNamed(MyHomePage.routeName);
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      setIsLoading(true);
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        setIsLoading(false);
        SnackBarHelper.showSuccessSnackBar(context, "Sign in Successful");
        Navigator.of(context).pushNamed(MyHomePage.routeName);
        return value;
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsLoading(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  bool _isLoadingForgetPassword = false;
  bool get isLoadingForgetPassword => _isLoadingForgetPassword;
  setIsLoadingForgetPassword(bool value){
    _isLoadingForgetPassword = value;
    notifyListeners();
  }

  forgotPassword(BuildContext context, email) async {
    try {
      setIsLoadingForgetPassword(true);
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        setIsLoadingForgetPassword(false);
        SnackBarHelper.showErrorSnackBar(
            context, "Link for reset password has been sent to your email");
      });
    } on FirebaseAuthException catch (firebaseError) {
      setIsLoadingForgetPassword(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsLoadingForgetPassword(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }

  bool _isLoadingLogout = false;
  bool get isLoadingLogout => _isLoadingForgetPassword;

  setIsLoadingLogout(bool value){
    _isLoadingForgetPassword = value;
    notifyListeners();
  }

  logOut(BuildContext context) async{
    try {
      setIsLoadingLogout(true);
      await _firebaseAuth.signOut().then((value) {
        setIsLoadingLogout(false);
        SnackBarHelper.showErrorSnackBar(
            context, "You have been logged out");
      });
    }
    on FirebaseAuthException catch (firebaseError) {
      setIsLoadingLogout(false);
      SnackBarHelper.showErrorSnackBar(context, firebaseError.message!);
    } catch (error) {
      setIsLoadingLogout(false);
      SnackBarHelper.showErrorSnackBar(context, error.toString());
    }
  }




}
