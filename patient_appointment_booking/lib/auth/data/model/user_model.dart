import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entitis/user_data.dart';
import '../../domain/entitis/user_entity.dart';
import 'userdata_model.dart';

class UserModel extends Equatable {
  final String email;
  final UserData userdata;
  const UserModel({
    required this.email,
    required this.userdata,
  });

  factory UserModel.fromFirebase(DocumentSnapshot snapshot) => UserModel(
      email: snapshot['email'] ?? '',
      userdata: UserDataModel.fromFirebase(snapshot).toEntity());

  UserEntity toEntity() => UserEntity(email: email, userdata: userdata);

  @override
  List<Object?> get props => [email, userdata];
}
