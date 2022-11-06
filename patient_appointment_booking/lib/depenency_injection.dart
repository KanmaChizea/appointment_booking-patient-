import 'package:get_it/get_it.dart';

import 'auth/auth_injection.dart' as auth;
import 'dashboard/dasboard_injection.dart' as dashboard;

final sl = GetIt.instance;

void init() {
  auth.init();
  dashboard.init();
}
