import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entitis/user_data.dart';
import '../../domain/usecases/fetch_user.dart';

class UserDataCubit extends Cubit<UserData> {
  UserDataCubit(FetchUserDataUsecase usecase)
      : _usecase = usecase,
        super(const UserData(
            firstName: '', lastName: '', department: '', faculty: '', id: ''));
  final FetchUserDataUsecase _usecase;

  void fetchUser(String id) {
    final data = _usecase(id);
    data.listen((event) {
      emit(event);
    });
  }
}
