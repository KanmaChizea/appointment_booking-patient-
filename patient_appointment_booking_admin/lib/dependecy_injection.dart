import 'package:get_it/get_it.dart';

import 'auth/auth_di.dart' as auth;

final sl = GetIt.instance;

void init() {
  auth.init();
}
