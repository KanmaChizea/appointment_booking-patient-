import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_appointment_booking/auth/domain/entitis/user_data.dart';

import '../../domain/usecases/edit_profile.dart';

class ProfileState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileFailed extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(EditProfileUsecase usecase)
      : _usecase = usecase,
        super(ProfileInitial());
  final EditProfileUsecase _usecase;

  Future<void> getProfile(UserData data) async {
    try {
      emit(ProfileLoading());
      await _usecase(data);
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileFailed());
    }
  }
}
