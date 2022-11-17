part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);
  @override
  List<Object> get props => [message];
}

class AuthSignedIn extends AuthState {}

class AuthSignedOut extends AuthState {}
