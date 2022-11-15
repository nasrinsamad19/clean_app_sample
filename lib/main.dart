import 'dart:io';

import 'package:clean_app_sample/features/home/presentation/pages/home.dart';
import 'package:clean_app_sample/features/home/presentation/widgets/navigationbar.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_local_data_source.dart';
import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_email/update_email_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_email_by_code/update_email_by_code_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_image/update_image_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/pages/profilePage.dart';
import 'package:clean_app_sample/features/profile/presentation/pages/profile_edit.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/bloc/sign_in_bloc.dart';
import 'package:clean_app_sample/features/splash_screen/presentation/pages/splash_screen_page.dart';
import 'package:clean_app_sample/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_app_sample/features/users/presentation/pages/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/login/presentation/pages/login_page.dart';

String platform = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoginLocalDataSources? localDataSources;

  @override
  void initState() {
    super.initState();
    detectPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<LoginBloc>()),
          BlocProvider(create: (_) => di.sl<SignInBloc>()),
          BlocProvider(create: (_) => di.sl<UsersBloc>()),
          BlocProvider(create: (_) => di.sl<ProfileBloc>()),
          BlocProvider(create: (_) => di.sl<UpdateProfileBloc>()),
          BlocProvider(create: (_) => di.sl<UpdateImageBloc>()),
          BlocProvider(create: (_) => di.sl<UpdatePasswordBloc>()),
          BlocProvider(create: (_) => di.sl<UpdateEmailBloc>()),
          BlocProvider(create: (_) => di.sl<UpdateEmailByCodeBloc>())
        ],
        child: MaterialApp(
          theme: ThemeData(),
          home: LoginPage(),
        ));
  }

  void detectPlatform() {
    if (Platform.isAndroid) {
      platform = "android";
    } else if (Platform.isIOS) {
      platform = "ios";
    }
  }
}
