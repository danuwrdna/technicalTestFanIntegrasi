import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final bool emailVerified; 

  UserModel({
    required this.uid,
    required this.email,
    required this.emailVerified,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot.id,
      email: snapshot['email'],
      emailVerified:
          snapshot['emailVerified'], 
    );
  }
    factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    Map<String, dynamic> data = doc.data()!;
    return UserModel(
      uid: doc.id,
      email: data['email'],
      emailVerified: data['emailVerified'],
    );
  }
}
