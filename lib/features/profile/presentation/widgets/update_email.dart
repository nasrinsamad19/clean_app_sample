import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_email/update_email_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_email_by_code/update_email_by_code_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/alert.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateEmailWidget extends StatefulWidget {
  const UpdateEmailWidget({Key? key}) : super(key: key);

  @override
  State<UpdateEmailWidget> createState() => _UpdateEmailWidgetState();
}

class _UpdateEmailWidgetState extends State<UpdateEmailWidget> {
  TextEditingController neEmail = TextEditingController();
  TextEditingController code = TextEditingController();
  var oldPasswordData;
  var newPasswordData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UpdateEmailBloc>(context).emit(UpdateEmailInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CommonAppbar(),
        preferredSize: Size.fromHeight(height(context) / 5),
      ),
      body: BlocConsumer<UpdateEmailBloc, UpdateEmailState>(
        listener: (context, state) => {},
        builder: (context, state) {
          print("state is $state");
          if (state is UpdateEmailInitial) {
            return _buildEmailbody();
          }
          if (state is ErrorUpdateEmailState) {
            return Center(child: Text(state.message));
          }
          if (state is LoadingUpdateEmailState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SuccessUpdateEmailState) {
            var emailToken = state.emailToken;
            return _buildCodebody(context, emailToken);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _buildCodebody(BuildContext context, String emailToken) {
    return BlocBuilder<UpdateEmailByCodeBloc, UpdateEmailByCodeState>(
      builder: (context, state) {
        print("state is $state");
        if (state is UpdateEmailByCodeInitial) {
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
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: code,
                        autofillHints: [AutofillHints.oneTimeCode],
                        //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                        keyboardType: TextInputType.number,
                        maxLength: 6,

                        decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                color: MyColors.lightFont, fontSize: 13),
                            labelText: 'OTP'),

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
                              textColor: MyColors.white,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  BlocProvider.of<UpdateEmailByCodeBloc>(
                                          context)
                                      .add(UpdateEmailByCodeProfileEvent(
                                          code: code.text,
                                          emailToken: emailToken,
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
        if (state is ErrorUpdateEmailByCodeState) {
          return AlertMessage().alert(context, state.message);
        }
        if (state is LoadingUpdateEmailByCodeState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SuccessUpdateEmailByCodeState) {
          return AlertMessage().alert(context, state.message);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  _buildEmailbody() {
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
                  controller: neEmail,
                  autofillHints: [AutofillHints.email],
                  //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle:
                          TextStyle(color: MyColors.lightFont, fontSize: 13),
                      labelText: 'New Email'),

                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter New Email';
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
                        textColor: MyColors.white,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            BlocProvider.of<UpdateEmailBloc>(context).add(
                                UpdateProfileEmailEvent(
                                    newEmail: neEmail.text, context: context));
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
