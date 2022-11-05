import '../entitis/user_data.dart';
import '../entitis/user_entity.dart';

abstract class AuthInterface {
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signUp(String email, String password, UserData userData);
  Future<void> logout();
  Future<UserEntity?> fetchUser();
}
