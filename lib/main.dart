import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/bloc/sign_in_bloc.dart';
import 'package:clean_app_sample/features/splash_screen/presentation/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/login/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<LoginBloc>()),
          BlocProvider(create: (_) => di.sl<SignInBloc>()),
        ],
        child: MaterialApp(
          title: 'Number Trivia',
          theme: ThemeData(
              //primaryColor: Colors.green.shade800,
              //accentColor: Colors.green.shade600,
              ),
          home: SplashPage(),
        ));
  }
}
