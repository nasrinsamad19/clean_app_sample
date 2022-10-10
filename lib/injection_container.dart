import 'package:clean_app_sample/features/login/data/datasources/login_remote_data_source.dart';
import 'package:clean_app_sample/features/login/data/repo/login_repo_iml.dart';
import 'package:clean_app_sample/features/login/domain/repo/login_repo.dart';
import 'package:clean_app_sample/features/login/domain/usecases/login_usecase.dart';
import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  initInjections(serviceLocator);
}

void initInjections(GetIt serviceLocator) {
  serviceLocator.registerFactory(() => LoginBloc(loginUseCase: serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => Login(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<LoginRepo>(
    () => LoginRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => LoginUser(),
  );
}
