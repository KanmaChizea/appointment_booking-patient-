import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:patient_appointment_booking_admin/auth/domain/usecase/sign_in_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required SignInUseCase signInUseCase,
  })  : _signInUseCase = signInUseCase,
        super(AuthSignedOut());

  final SignInUseCase _signInUseCase;

  void signOut() {
    emit(AuthSignedOut());
  }

  Future<void> signIn(String password) async {
    emit(AuthLoading());
    try {
      final val = await _signInUseCase(password);
      val ? emit(AuthSignedIn()) : emit(const AuthFailed('Wrong password'));
    } catch (e) {
      emit(AuthFailed(e.toString().substring(10)));
    }
  }
}
