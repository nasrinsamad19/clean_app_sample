import 'package:clean_app_sample/core/platform/network_info.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_local_data_source.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_remote_data_source.dart';
import 'package:clean_app_sample/features/login/data/repo/login_repo_iml.dart';
import 'package:clean_app_sample/features/login/domain/repo/login_repo.dart';
import 'package:clean_app_sample/features/login/domain/usecases/login_usecase.dart';
import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:clean_app_sample/features/sign_in/data/datasources/sign_in_remote_datasources.dart';
import 'package:clean_app_sample/features/sign_in/data/repo/signIn_repo_impl.dart';
import 'package:clean_app_sample/features/sign_in/domain/repo/sign_in_repo.dart';
import 'package:clean_app_sample/features/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/bloc/sign_in_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  /// Bloc
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));

  sl.registerFactory(() => SignInBloc(signInUsecase: sl()));

  /// UseCases
  sl.registerLazySingleton(
    () => LoginUseCase(
      loginRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SignInUsecase(
      signInRepositories: sl(),
    ),
  );

  /// Repository
  sl.registerLazySingleton<LoginRepo>(
    () => LoginRepositoryImpl(
      logInRemoteDataSources: sl(),
      loginLocalDataSources: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SignInRepositories>(
      () => SignInRepoImp(signInRemoteDataSource: sl(), networkInfo: sl()));

  /// DataSources
  sl.registerLazySingleton<LogInRemoteDataSources>(
    () => LogInRemoteDataSourcesImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<LoginLocalDataSources>(
    () => LoginLocalDataSourcesRepoImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<SignInRemoteDataSource>(
    () => SignInRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  ///////////////////////////////////  global  /////////////////////////////////////
  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () => sharedPreferences,
  );
  sl.registerLazySingleton(
    () => http.Client(),
  );
  sl.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );
}
