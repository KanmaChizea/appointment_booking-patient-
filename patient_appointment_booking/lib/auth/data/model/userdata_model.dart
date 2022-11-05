import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entitis/user_data.dart';

class UserDataModel extends Equatable {
  final String firstName;
  final String lastName;
  final String department;
  final String faculty;
  final String id;
  const UserDataModel({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.faculty,
    required this.id,
  });

  factory UserDataModel.fromFirebase(DocumentSnapshot snapshot) {
    return UserDataModel(
        firstName: snapshot['firstName'] ?? '',
        lastName: snapshot['lastName'] ?? '',
        department: snapshot['department'] ?? '',
        faculty: snapshot['faculty'] ?? '',
        id: snapshot['id'] ?? '');
  }

  UserData toEntity() {
    return UserData(
        firstName: firstName,
        lastName: lastName,
        department: department,
        faculty: faculty,
        id: id);
  }

  @override
  List<Object?> get props => [id];
}
