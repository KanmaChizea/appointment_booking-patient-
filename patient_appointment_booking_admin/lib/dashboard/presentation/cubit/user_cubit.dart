import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/entity/user_entity.dart';
import 'package:patient_appointment_booking_admin/dashboard/domain/usecase/get_users_usecase.dart';

class UserCubit extends Cubit<UserData> {
  UserCubit(GetUsersUsecase usecase)
      : _usecase = usecase,
        super(const UserData(
            firstName: '', lastName: '', department: '', faculty: '', id: ''));

  final GetUsersUsecase _usecase;
  List userList = [];

  void getAllUsers() {
    _usecase().listen((event) {
      userList = event;
    });
  }

  void getUserData(String id) {
    final user = userList.where((element) => element.id == id);
    emit(user.first);
  }
}
