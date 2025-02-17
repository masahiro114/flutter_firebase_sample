import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final DateTime birthDate;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.birthDate,
    required this.createdAt,
  });

  /// 🔹 Convert Firestore document to `UserModel`
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid: documentId,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      birthDate: (data['birthDate'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  /// 🔹 Convert `UserModel` to Firestore document format
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'birthDate': Timestamp.fromDate(birthDate), // Convert DateTime to Firestore Timestamp
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
