import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:technicaltestfan/model/UserModel.dart';
import 'package:rxdart/rxdart.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(
      String uid, String email, String password, bool emailVerified) async {
    try {
      await _db.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'emailVerified': emailVerified,
      });
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  Future<void> updateEmailVerificationStatus(
      String email, bool verified) async {
    try {
      await _db.collection('users').doc(email).update({
        'emailVerified': verified,
      });
    } catch (e) {
      print('Error updating email verification status: $e');
    }
  }

  Stream<List<UserModel>> streamUsers() {
    return _db.collection('users').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromSnapshot(doc))
        .where((user) => user.email.isNotEmpty && user.emailVerified)
        .toList());
  }

  Stream<List<UserModel>> streamUnverifiedUsers() {
    return _db.collection('users').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromSnapshot(doc))
        .where((user) => user.email.isNotEmpty && !user.emailVerified)
        .toList());
  }

  Stream<List<UserModel>> streamAllUsers() {
    return Rx.combineLatest2(
      streamUsers(),
      streamUnverifiedUsers(),
      (List<UserModel> users, List<UserModel> unverifiedUsers) {
        List<UserModel> allUsers = [...users, ...unverifiedUsers];
        return allUsers;
      },
    );
  }

  Stream<List<UserModel>> searchUsersByEmail(String email) {
    return _db
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: email)
        .where('email', isLessThanOrEqualTo: email + '\uf8ff')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromFirestore(doc, null))
            .toList());
  }

  Stream<List<UserModel>> filterUsersByEmailVerification(bool isVerified) {
    return _db
        .collection('users')
        .where('emailVerified', isEqualTo: isVerified)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserModel.fromFirestore(doc, null))
            .toList());
  }
}
