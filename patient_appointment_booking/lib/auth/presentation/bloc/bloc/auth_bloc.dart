import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entitis/user_data.dart';
import '../../../domain/entitis/user_entity.dart';
import '../../../domain/usecases/check_login_status.dart';
import '../../../domain/usecases/create_account.dart';
import '../../../domain/usecases/sign_in.dart';
import '../../../domain/usecases/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required CreateAccountUsecase createAccountUsecase,
      required SignInUsecase signInUsecase,
      required SignOutUsecase signOutUsecase,
      required CheckLoginStatusUsecase checkLoginStatusUsecase})
      : _createAccountUsecase = createAccountUsecase,
        _signInUsecase = signInUsecase,
        _signOutUsecase = signOutUsecase,
        _checkLoginStatusUsecase = checkLoginStatusUsecase,
        super(AuthInitial()) {
    on<AuthSignIn>(_onSignIn);
    on<AuthSignOut>(_onSignOut);
    on<AuthSignUp>(_onSignUp);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  final CreateAccountUsecase _createAccountUsecase;
  final SignInUsecase _signInUsecase;
  final SignOutUsecase _signOutUsecase;
  final CheckLoginStatusUsecase _checkLoginStatusUsecase;

  _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await _signOutUsecase();
      emit(AuthSignedOut());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailed(e.message ?? ''));
    } catch (e) {
      emit(const AuthFailed('Something went wrong'));
    }
  }

  _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final entity = await _signInUsecase(event.email, event.password);
      emit(AuthSignedIn(entity));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailed(e.message ?? ''));
    } catch (e) {
      emit(const AuthFailed('Something went wrong'));
    }
  }

  _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final entity = await _createAccountUsecase(
          event.email, event.password, event.userData);
      emit(AuthSignedIn(entity));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailed(e.message ?? ''));
    } catch (e) {
      emit(const AuthFailed('Something went wrong'));
    }
  }

  void _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    final user = await _checkLoginStatusUsecase.call();
    user == null ? emit(AuthSignedOut()) : emit(AuthSignedIn(user));
  }
}
