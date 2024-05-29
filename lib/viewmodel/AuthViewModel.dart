import 'package:flutter/material.dart';
import 'package:technicaltestfan/service/AuthService.dart';
import 'package:technicaltestfan/service/FireStoreService.dart';

class AuthViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FireStoreService _firestoreService = FireStoreService();

  Future<void> signUp(String email, String password) async {
    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        await _firestoreService.createUser(
            user.uid, email, password, user.emailVerified);
        if (!user.emailVerified) {
          await _authService.sendEmailVerification();
        }
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<bool> signIn(String email, String password) async {
    final user = await _authService.signIn(email, password);
    if (user != null) {
      return _authService.isEmailVerified();
    }
    return false;
  }
}
