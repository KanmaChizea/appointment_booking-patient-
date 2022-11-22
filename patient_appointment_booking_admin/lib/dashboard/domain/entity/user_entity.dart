import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String firstName;
  final String lastName;
  final String department;
  final String faculty;
  final String id;
  const UserData({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.faculty,
    required this.id,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? department,
    String? faculty,
    String? id,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      department: department ?? this.department,
      faculty: faculty ?? this.faculty,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'department': department,
      'faculty': faculty,
      'id': id,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      department: map['department'] ?? '',
      faculty: map['faculty'] ?? '',
      id: map['id'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserData(firstName: $firstName, lastName: $lastName, department: $department, faculty: $faculty, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.department == department &&
        other.faculty == faculty &&
        other.id == id;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        department.hashCode ^
        faculty.hashCode ^
        id.hashCode;
  }

  @override
  List<Object?> get props => [id];
}
