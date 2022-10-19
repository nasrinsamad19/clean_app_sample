import 'dart:math';

import 'package:clean_app_sample/features/home/presentation/pages/home.dart';
import 'package:clean_app_sample/features/login/presentation/bloc/login_bloc.dart';
import 'package:clean_app_sample/features/login/presentation/pages/login_page.dart';
import 'package:clean_app_sample/features/login/presentation/widgets/loading_widget.dart';
import 'package:clean_app_sample/features/sign_in/presentaion/bloc/sign_in_bloc.dart';
import 'package:clean_app_sample/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({Key? key}) : super(key: key);

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String dateOfBirth;
  late String phoneNumber;
  String _errorMessage = 'Enter valid email';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocProvider(
      create: (_) => sl<SignInBloc>(),
      child: BlocConsumer<SignInBloc, SignInState>(
        builder: (BuildContext context, state) {
          print("state is $state");
          if (state is SignInInitial) {
            return _buildForm(context);
          } else if (state is CheckingSignState) {
            return LoadingWidget();
          } else {
            return _buildForm(context);
          }
        },
        listener: (context, state) {
          if (state is ErrorSignState) {
            final snackBar = SnackBar(content: Text(state.message));
            // ignore: deprecated_member_use
            Scaffold.of(context).showSnackBar(snackBar);
          } else if (state is LoadedSignState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
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
                          hintText: 'Enter the Firstname',
                          labelText: 'Firstname',
                        ),
                        onChanged: (value) {
                          firstName = value;
                        },
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          return value!.isEmpty ? 'Name is mandatory' : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
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
                          hintText: 'Enter the last name',
                          labelText: 'Last Name',
                        ),
                        onChanged: (value) {
                          lastName = value;
                        },
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          return value!.isEmpty
                              ? 'last name is mandatory'
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Email',
                          labelText: 'Email',
                        ),
                        onChanged: (value) {
                          validateEmail(value);
                          email = value;
                        },
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Enter valid Email ",
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
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
                          hintText: 'Enter phone Number',
                          labelText: 'Phone Number',
                        ),
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Phone Number is mandatory'
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          hintText: 'Enter date of birth',
                          labelText: 'Date Of Birth',
                        ),
                        onChanged: (value) {
                          dateOfBirth = value;
                        },
                        onSaved: (value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          return value!.isEmpty
                              ? 'last name is mandatory'
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
                          hintText: 'Enter password',
                          labelText: 'Password',
                        ),
                        onChanged: (value) {
                          password = value;
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
                          BlocProvider.of<SignInBloc>(context)
                              .add(SignInUserEvent(
                            context: context,
                            firstName: firstName,
                            lastName: lastName,
                            phoneNumber: phoneNumber,
                            email: email,
                            dateOfBirth: dateOfBirth,
                            password: password,
                          ));
                        }
                      },
                      child: Text(
                        "Sign In",
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

  void validateEmail(String val) {
    if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      email = val;
    }
  }
}
