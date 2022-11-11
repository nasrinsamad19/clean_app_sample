import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/widgets/appbar_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userIamge;
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
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: ProfileAppbar(
            isEdit: false,
          ),
          preferredSize: Size.fromHeight(height(context) / 3.5)),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          print("state is $state");
          if (state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorGetProfileState) {
            return Center(child: Text(state.message));
          }

          if (state is SuccessGetProfileState) {
            if (state.profile.username.isEmpty) {
              return const Center(
                child: Text("No Profile"),
              );
            } else {
              return _buildBody(context, state);
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SuccessGetProfileState state) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 40, top: 40),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      '${Constants.imgPath}user.png',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                              color: MyColors.lightFont, fontSize: 13),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.profile.username,
                          style: TextStyle(
                              color: MyColors.font,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      '${Constants.imgPath}email.png',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              color: MyColors.lightFont, fontSize: 13),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.profile.email,
                          style: TextStyle(
                              color: MyColors.font,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      '${Constants.imgPath}password.png',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                              color: MyColors.lightFont, fontSize: 13),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '*******',
                          style: TextStyle(
                              color: MyColors.font,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      '${Constants.imgPath}phone.png',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: TextStyle(
                              color: MyColors.lightFont, fontSize: 13),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.profile.phone,
                          style: TextStyle(
                              color: MyColors.font,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      '${Constants.imgPath}company.png',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company',
                          style: TextStyle(
                              color: MyColors.lightFont, fontSize: 13),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.profile.companyName,
                          style: TextStyle(
                              color: MyColors.font,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
