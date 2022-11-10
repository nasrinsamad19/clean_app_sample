import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/profile/data/model/profile_model.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/appbar_profile.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/password_change.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/update_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  var phoneController;
  var userIamge;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var usernameController;
  var emailController;

  @override
  initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(
      context,
    ).add(GetProfileEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: PreferredSize(
          child: ProfileAppbar(
            isEdit: true,
          ),
          preferredSize: Size.fromHeight(height(context) / 3.5)),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          print("state is $state");
          if (state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorGetProfileState) {
            return const Center(child: Text('Error'));
          }

          if (state is SuccessGetProfileState) {
            if (state.profile.username.isEmpty) {
              return const Center(
                child: Text("No Profile"),
              );
            }

            userIamge = state.profile.image;
            return _buildBody(context, state);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SuccessGetProfileState state) {
    userIamge = state.profile.image;
    ProfileModel profileModel;

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    //controller: usernameController,
                    initialValue: state.profile.username,
                    autofillHints: [AutofillHints.username],
                    //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                    decoration: InputDecoration(
                        hintText: state.profile.username,
                        border: InputBorder.none,
                        icon: Image.asset(
                          '${Constants.imgPath}user.png',
                          scale: 1.8,
                        ),
                        labelStyle:
                            TextStyle(color: MyColors.lightFont, fontSize: 13),
                        labelText: 'Username'),

                    onChanged: (value) {
                      value == usernameController;
                    },
                    onSaved: (value) {
                      usernameController = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller:
                        TextEditingController(text: state.profile.email),
                    autofillHints: [AutofillHints.email],
                    //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          '${Constants.imgPath}email.png',
                          scale: 1.8,
                        ),
                        labelStyle:
                            TextStyle(color: MyColors.lightFont, fontSize: 13),
                        labelText: 'Email'),

                    onChanged: (value) {},
                    onSaved: (value) {
                      emailController = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Email';
                      }
                      return null;
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: TextEditingController(text: '***********'),

                    autofillHints: [AutofillHints.email],
                    //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          '${Constants.imgPath}password.png',
                          scale: 1.8,
                        ),
                        labelStyle:
                            TextStyle(color: MyColors.lightFont, fontSize: 13),
                        labelText: 'Password'),

                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller:
                        TextEditingController(text: state.profile.phone),
                    autofillHints: [AutofillHints.email],
                    //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          '${Constants.imgPath}phone.png',
                          scale: 1.8,
                        ),
                        labelStyle:
                            TextStyle(color: MyColors.lightFont, fontSize: 13),
                        labelText: 'Phone'),

                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Phone Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phoneController = value;
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller:
                        TextEditingController(text: state.profile.companyName),
                    autofillHints: [AutofillHints.email],
                    //onEditingComplete: ()=>TextInput.finishAutofillContext(),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          '${Constants.imgPath}company.png',
                          scale: 1.8,
                        ),
                        labelStyle:
                            TextStyle(color: MyColors.lightFont, fontSize: 13),
                        labelText: 'Company'),

                    onChanged: (value) {},
                    onSaved: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Company';
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
                    child: Column(
                      children: [
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
                                var data = Profile(
                                    username: usernameController,
                                    phone: phoneController,
                                    email: emailController,
                                    image: state.profile.image,
                                    userType: state.profile.userType,
                                    userTypeId: state.profile.userTypeId,
                                    companyId: state.profile.companyId,
                                    companyName: state.profile.companyName);
                                BlocProvider.of<UpdateProfileBloc>(context).add(
                                    UpdateProfileInfoEvent(
                                        profile: data, context: context));
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                              'Change Password',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const PasswordChangeWidget(),
                                  ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                              'Change Email',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const UpdateEmailWidget(),
                                  ));
                            },
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
