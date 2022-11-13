import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entitis/user_data.dart';
import '../../domain/usecases/edit_profile.dart';

class EditProfileState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileFailed extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(EditProfileUsecase usecase)
      : _usecase = usecase,
        super(EditProfileInitial());
  final EditProfileUsecase _usecase;

  Future<void> editProfile(UserData data) async {
    try {
      emit(EditProfileLoading());
      await _usecase(data);
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileFailed());
    }
  }
}
