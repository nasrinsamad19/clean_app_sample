import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_password/update_password_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/alert.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordChangeWidget extends StatefulWidget {
  const PasswordChangeWidget({Key? key}) : super(key: key);

  @override
  State<PasswordChangeWidget> createState() => _PasswordChangeWidgetState();
}

class _PasswordChangeWidgetState extends State<PasswordChangeWidget> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  var oldPasswordData;
  var newPasswordData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<UpdatePasswordBloc>(context).emit(UpdatePasswordInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppbar(),
        preferredSize: Size.fromHeight(height(context) * .06),
      ),
      body: BlocBuilder<UpdatePasswordBloc, UpdatePasswordState>(
        builder: (context, state) {
          print("state is $state");
          if (state is UpdatePasswordInitial) {
            return _buildBody();
          }
          if (state is LoadingUpdatePasswordState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ErrorUpdatePasswordState) {
            return Center(child: AlertMessage().alert(context, state.message));
          }

          if (state is SuccessUpdatePasswordState) {
            return Center(child: AlertMessage().alert(context, state.message));
          }

          return _buildBody();
        },
      ),
    );
  }

  _buildBody() {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(
                  //     //color: Color.fromARGB(255, 192, 190, 190)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.1,
                      ),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: oldPassword,
                  autofillHints: [AutofillHints.password],
                  obscureText: true,
                  //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle:
                          TextStyle(color: MyColors.lightFont, fontSize: 13),
                      labelText: 'Current Password'),

                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Current password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    oldPasswordData = value;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(
                  //     //color: Color.fromARGB(255, 192, 190, 190)),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      15,
                    ),
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.1,
                      ),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: newPassword,
                  obscureText: true,
                  autofillHints: [AutofillHints.password],
                  //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle:
                          TextStyle(color: MyColors.lightFont, fontSize: 13),
                      labelText: 'New Password'),

                  onChanged: (value) {},
                  onSaved: (value) {
                    newPasswordData = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter New Password';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(children: [
                    Container(
                      width: width(context),
                      decoration: BoxDecoration(
                        color: MyColors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      //margin: EdgeInsets.all(25),
                      child: FlatButton(
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            BlocProvider.of<UpdatePasswordBloc>(context).add(
                                UpdatePasswordProfileEvent(
                                    currentPassword: oldPassword.text,
                                    newPassword: newPassword.text,
                                    context: context));
                          }
                        },
                      ),
                    ),
                  ]))
            ],
          ),
        ));
  }
}
