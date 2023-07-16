import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/model/user/user_model.dart';
import 'package:frontend/data/repositories/user_repository.dart';
import 'package:frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:frontend/logic/services/preferences.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _initialize();
  }
  final UserRepository _userRepository = UserRepository();

  void _initialize() async {
    final userDetails = await Preferences.fetchUserDetails();
    String? email = userDetails['email'];
    String? password = userDetails['password'];
    log(email.toString());
    log(password.toString());
    if (email == null || password == null) {
      emit(UserLoggedOutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState(UserModel userModel, String email, String password) {
    Preferences.saveuserDetails(email, password);
    emit(UserLoggedInState(userModel));
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(UserLoadingState());
      UserModel userModel = await _userRepository.signIn(
        email: email,
        password: password,
      );
      _emitLoggedInState(userModel, email, password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void createAccount({
    required String email,
    required String password,
  }) async {
    emit(UserLoadingState());
    try {
      UserModel userModel = await _userRepository.createAccount(
        email: email,
        password: password,
      );
      _emitLoggedInState(userModel, email, password);
    } catch (ex) {
      emit(UserErrorState(ex.toString()));
    }
  }

  void signOut() {
    Preferences.clear();
    emit(UserLoggedOutState());
  }
}