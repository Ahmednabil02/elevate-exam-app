import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      final entity = LoginEntity(email: email, password: password);

      final token = await loginUseCase(entity);

      emit(LoginSuccess(token));
    } on DioException catch (e) {
      final message = e.response?.data["message"] ?? "Login failed";
      emit(LoginError(message));
    } catch (e) {
      emit(LoginError("An unexpected error occurred"));
    }
  }
}
