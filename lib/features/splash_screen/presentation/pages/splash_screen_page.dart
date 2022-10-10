import 'dart:async';

import 'package:clean_app_sample/features/login/presentation/dto/dto.dart';
import 'package:clean_app_sample/features/login/presentation/pages/login_page.dart';
import 'package:clean_app_sample/features/splash_screen/presentation/pages/home.dart';
import 'package:clean_app_sample/features/splash_screen/presentation/widgets/splash_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/splash_screen_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashScreenBloc _splashBloc = SplashScreenBloc();

  @override
  void initState() {
    _splashBloc.add(SetSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: // Color.fromARGB(255, 4, 60, 105)
            Colors.white,
        child: BlocProvider(
          create: (_) => _splashBloc,
          child: BlocListener<SplashScreenBloc, SplashScreenState>(
            listener: (context, state) {
              if (state is Loaded) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                  ),
                );
              }
            },
            child: _buildSplashWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildSplashWidget() {
    // ignore: prefer_const_constructors
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Limitless',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        Text(
          'Parking',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    ));
  }
}
