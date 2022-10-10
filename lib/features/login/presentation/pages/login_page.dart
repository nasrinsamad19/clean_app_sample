import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:clean_app_sample/features/login/presentation/dto/dto.dart';
import 'package:clean_app_sample/features/login/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _bloc;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String inputLogin;
  late String inputPassword;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _bloc = serviceLocator<LoginBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Demo'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is ErrorLoggedState) {
            final snackBar = SnackBar(content: Text('Invalid credentials...'));
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(snackBar);
          } else if (state is LoggedState) {
            final snackBar = SnackBar(content: Text('User logged...'));
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, state) {
            if (state is InitialLoginState) {
              return _buildForm();
            } else if (state is CheckingLoginState) {
              return LoadingWidget();
            } else {
              return _buildForm();
            }
          },
        ),
      ),
    );
  }

  _buildForm() {
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
                      'Sign in',
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
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Username is mandatory'
                              : null;
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
                          return value!.isEmpty
                              ? 'Password is mandatory'
                              : null;
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
                          final loginDTO = LoginDTO(
                            username: inputLogin,
                            password: inputPassword,
                          );
                          print(loginDTO);
                          _bloc.add(CheckLoginEvent(login: loginDTO));
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
