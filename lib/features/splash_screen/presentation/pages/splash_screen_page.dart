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


  @override
  void initState() {
  //  _splashBloc.add(SetSplash());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: initPage(true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != true) {
              Future.delayed(const Duration(seconds: 2), () {
               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>LoginPage()));
              });
            } else {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>LoginPage()));

              });
            }
          }
          return Container(
            decoration: const BoxDecoration(
              color: Colors.grey,

            ),
            child:
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 5,
                      left: MediaQuery.of(context).size.width  / 20,
                      right: MediaQuery.of(context).size.width / 20,
                    ),
                    child: Text('Welcome')
                  ),
                )

          );
        },
      ),
    );
  }

  Future<bool> initPage(bool isAuth) async {

    return isAuth;
  }

}
