import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_data.dart';

class UserEntity extends Equatable {
  String email;
  UserData userdata;
  UserEntity({
    required this.email,
    required this.userdata,
  });

  UserEntity copyWith({
    String? email,
    UserData? userdata,
  }) {
    return UserEntity(
      email: email ?? this.email,
      userdata: userdata ?? this.userdata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userdata': userdata.toMap(),
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      email: map['email'] ?? '',
      userdata: UserData.fromMap(map['userdata']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  String toString() => 'UserEntity(email: $email, userdata: $userdata)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.email == email &&
        other.userdata == userdata;
  }

  @override
  int get hashCode => email.hashCode ^ userdata.hashCode;

  List<Object?> get props => [email, userdata];
}
