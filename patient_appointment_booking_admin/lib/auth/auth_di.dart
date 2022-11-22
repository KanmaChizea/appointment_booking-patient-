import 'package:get_it/get_it.dart';
import 'data/repository/auth_repository.dart';
import 'data/source/auth_datasource.dart';
import 'domain/interface/auth_interface.dart';
import 'domain/usecase/sign_in_usecase.dart';
import 'presentation/cubit/auth_cubit.dart';

final _sl = GetIt.instance;

void init() {
  _sl.registerFactory(() => AuthCubit(signInUseCase: _sl()));
  _sl.registerLazySingleton(() => SignInUseCase(_sl()));
  _sl.registerLazySingleton<AuthInterface>(() => AuthRepository(_sl()));
  _sl.registerLazySingleton(() => AuthDataSource());
}
