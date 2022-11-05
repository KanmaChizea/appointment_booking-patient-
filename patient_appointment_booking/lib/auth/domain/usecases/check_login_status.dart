import 'package:patient_appointment_booking/auth/domain/entitis/user_entity.dart';

import '../repositories/auth_interface.dart';

class CheckLoginStatusUsecase {
  CheckLoginStatusUsecase(AuthInterface authInterface)
      : _authInterface = authInterface;

  final AuthInterface _authInterface;

  Future<UserEntity?> call() async {
    return await _authInterface.fetchUser();
  }
}
