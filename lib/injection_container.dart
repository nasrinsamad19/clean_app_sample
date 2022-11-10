import 'package:clean_app_sample/core/platform/network_info.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_local_data_source.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_remote_data_source.dart';
import 'package:clean_app_sample/features/login/data/repo/login_repo_iml.dart';
import 'package:clean_app_sample/features/login/domain/repo/login_repo.dart';
import 'package:clean_app_sample/features/login/domain/usecases/login_usecase.dart';
import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:clean_app_sample/features/profile/data/datasources/profile_remote_datasources.dart';
import 'package:clean_app_sample/features/profile/data/repo/profile_repository_imp.dart';
import 'package:clean_app_sample/features/profile/domain/repositories/profile_repository.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_email.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_email_by_code.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_image_use_case.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:clean_app_sample/features/profile/domain/usecases/update_profile_info_use_case.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_email/update_email_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_email_by_code/update_email_by_code_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_image/update_image_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:clean_app_sample/features/sign_in/data/datasources/sign_in_remote_datasources.dart';
import 'package:clean_app_sample/features/sign_in/data/repo/signIn_repo_impl.dart';
import 'package:clean_app_sample/features/sign_in/domain/repo/sign_in_repo.dart';
import 'package:clean_app_sample/features/sign_in/domain/usecases/sign_in_usecase.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/bloc/sign_in_bloc.dart';
import 'package:clean_app_sample/features/users/data/datasource/users_remote_datasources.dart';
import 'package:clean_app_sample/features/users/data/repo/users_repo_impl.dart';
import 'package:clean_app_sample/features/users/domain/repo/users_repo.dart';
import 'package:clean_app_sample/features/users/domain/usecases/get_users.dart';
import 'package:clean_app_sample/features/users/presentation/bloc/users_bloc.dart';
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

  // sl.registerLazySingleton<SignInRepositories>(
  //     () => SignInRepoImp(signInRemoteDataSource: sl(), networkInfo: sl()));

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
  // sl.registerLazySingleton<SignInRemoteDataSource>(
  //   () => SignInRemoteDataSourceImpl(
  //     client: sl(),
  //   ),
  // );
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

  ///////////////////////////////////  Users /////////////////////////////////////
  /// Bloc
  sl.registerFactory(() => UsersBloc(getUsersUseCase: sl()));

  /// UseCases
  sl.registerLazySingleton(() => GetUsersUseCase(usersRepositories: sl()));

  /// Repository
  sl.registerLazySingleton<UsersRepositories>(() => UsersRepoImpl(
      networkInfo: sl(),
      usersRemoteDataSources: sl(),
      loginLocalDataSources: sl(),
      logInRemoteDataSources: sl()));

  /// DataSources
  sl.registerLazySingleton<UsersRemoteDataSources>(
    () => UsersRemoteDataSourcesImpl(
      client: sl(),
    ),
  );
  ////////////////////////////////////////////// Profile Bloc's //////////////////////////////////////
  /// Bloc
  sl.registerFactory(() => ProfileBloc(sl()));
  sl.registerFactory(() => UpdateProfileBloc(sl()));
  sl.registerFactory(() => UpdateImageBloc(sl()));

  sl.registerFactory(() => UpdatePasswordBloc(sl()));

  sl.registerFactory(() => UpdateEmailBloc(sl()));
  sl.registerFactory(() => UpdateEmailByCodeBloc(sl()));

  /// UseCases
  sl.registerLazySingleton(
    () => GetProfileUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateProfileInfoUseCase(sl()),
  );
  sl.registerLazySingleton(() => UpdateProfileImageUseCase(sl()));
  sl.registerLazySingleton(
    () => UpdatePasswordUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateEmailUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateEmailByCode(sl()),
  );

  /// Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImp(sl(), sl(), sl(), sl()),
  );

  /// DataSources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImp(
      sl(),
    ),
  );
}
