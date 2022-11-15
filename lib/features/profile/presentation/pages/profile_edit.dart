import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/profile/data/model/profile_model.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/alert.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/appbar_profile.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/password_change.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/update_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  final Profile profile;
  const ProfileEditPage({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  var phoneController;
  var userIamge;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var usernameController;
  var comapnyName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UpdateProfileBloc>(context).emit(UpdateProfileInitial());
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              _buildBody(context),
              BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
                builder: (context, state) {
                  print("state is $state");
                  if (state is UpdateProfileInitial) {
                    return Container();
                  }
                  if (state is LoadingUpdateProfileInfoState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ErrorUpdateProfileInfoState) {
                    return Center(
                        child: AlertMessage().alert(context, state.message));
                  }

                  if (state is SuccessUpdateProfileInfoState) {
                    return Center(
                        child: AlertMessage().alert(context, state.message));
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
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
                    initialValue: widget.profile.username,
                    autofillHints: [AutofillHints.username],
                    decoration: InputDecoration(
                        hintText: widget.profile.username,
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
                    initialValue: widget.profile.phone,
                    autofillHints: [AutofillHints.email],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Image.asset(
                          '${Constants.imgPath}phone.png',
                          scale: 1.8,
                        ),
                        labelStyle:
                            TextStyle(color: MyColors.lightFont, fontSize: 13),
                        labelText: 'Phone'),
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
                                  email: widget.profile.email,
                                  image: widget.profile.image,
                                  userType: widget.profile.userType,
                                  userTypeId: widget.profile.userTypeId,
                                  companyId: widget.profile.companyId,
                                  companyName: widget.profile.companyName,
                                );
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
                              Navigator.push(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const UpdateEmailWidget(),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
