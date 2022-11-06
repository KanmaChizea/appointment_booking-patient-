import '../model/user_model.dart';
import '../source/auth_datasource.dart';
import '../../domain/entitis/user_entity.dart';
import '../../domain/entitis/user_data.dart';
import '../../domain/repositories/auth_interface.dart';

class AuthRepository implements AuthInterface {
  AuthRepository({required AuthDataSource authDataSource})
      : _dataSource = authDataSource;
  final AuthDataSource _dataSource;
  @override
  Future<void> logout() async {
    try {
      await _dataSource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    try {
      final user = await _dataSource.signIn(email, password);
      final data = await _dataSource.fetchData(user?.uid ?? '');
      return UserModel(email: email, userdata: data).toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUp(
      String email, String password, UserData userData) async {
    try {
      final user = await _dataSource.signUp(email, password);
      await _dataSource.saveData(userData, user?.uid ?? '');
      final data = await _dataSource.fetchData(user?.uid ?? '');
      return UserModel(email: email, userdata: data).toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserEntity?> fetchUser() async {
    final user = await _dataSource.fetchUser;
    if (user != null) {
      final userdata = await _dataSource.fetchData(user.uid);
      return UserModel(email: user.email ?? '', userdata: userdata).toEntity();
    } else {
      return null;
    }
  }
}
