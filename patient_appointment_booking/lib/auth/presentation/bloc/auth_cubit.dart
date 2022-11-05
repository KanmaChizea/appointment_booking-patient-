import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<bool> {
  AuthCubit() : super(true);

  void toggletoLogin() {
    emit(true);
  }

  void toggletoSignup() {
    emit(false);
  }
}
