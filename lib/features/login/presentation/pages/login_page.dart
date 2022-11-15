import 'package:clean_app_sample/features/home/presentation/pages/home.dart';
import 'package:clean_app_sample/features/login/data/datasources/login_local_data_source.dart';
import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:clean_app_sample/features/login/presentation/dto/dto.dart';
import 'package:clean_app_sample/features/login/presentation/widgets/loading_widget.dart';
import 'package:clean_app_sample/features/profile/presentation/pages/profilePage.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/bloc/sign_in_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late LoginBloc _bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String inputLogin;
  late String inputPassword;

  @override
  void dispose() {
    // _bloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // _bloc = serviceLocator<LoginBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        builder: (BuildContext context, state) {
          print("state is $state");
          if (state is InitialLoginState) {
            return _buildForm(context);
          } else if (state is LoadingLoginState) {
            return LoadingWidget();
          } else {
            return _buildForm(context);
          }
        },
        listener: (context, state) {
          if (state is ErrorLoginState) {
            final snackBar = SnackBar(content: Text(state.message));
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(snackBar);
          } else if (state is LoadedLoginState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }

  _buildForm(BuildContext context) {
    print('dfef');
    return Form(
        key: _formKey,
        //autovalidate: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 4, 60, 105),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log in',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          hintText: 'Enter the username',
                          labelText: 'Email',
                        ),
                        onChanged: (value) {
                          inputLogin = value;
                        },
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        // validator: (value) => EmailValidator.validate(value!)
                        //     ? null
                        //     : "Enter valid Email ",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'username is mandatory';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 40.0,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          hintText: 'Enter the password',
                          labelText: 'Password',
                        ),
                        onChanged: (value) {
                          inputPassword = value;
                        },
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is mandatory';
                          } else if (value.length < 8) {
                            return 'minimum length is 8 ';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 40,
                      color: Color.fromARGB(255, 4, 60, 105),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginUserEvent(
                            context: context,
                            password: inputPassword,
                            username: inputLogin,
                          ));
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
