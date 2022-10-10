import 'package:bloc/bloc.dart';
import 'package:clean_app_sample/features/login/domain/entities/login.dart';
import 'package:clean_app_sample/features/login/domain/usecases/login_usecase.dart';
import 'package:clean_app_sample/features/login/presentation/dto/dto.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(InitialLoginState()) {
    on<LoginEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is CheckLoginEvent) {
        // yield CheckingLoginState();
        final result = await loginUseCase.call(
          Params(
            login: LoginModel(
              username: event.login.username,
              password: event.login.password,
            ),
          ),
        );
        // yield result.fold(
        //   (failure) => ErrorLoggedState(),
        //   (value) => (value) ? LoggedState() : ErrorLoggedState(),
        // );
      }
    });
  }
}
