part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  const AuthSignIn({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final UserData userData;
  const AuthSignUp({
    required this.email,
    required this.password,
    required this.userData,
  });
}

class AuthSignOut extends AuthEvent {}
