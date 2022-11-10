import 'dart:io';
import 'dart:ui';

import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/home/presentation/pages/home.dart';
import 'package:clean_app_sample/features/profile/data/model/profile_model.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_image/update_image_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/pages/profile_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAppbar extends StatefulWidget {
  final bool isEdit;
  const ProfileAppbar({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<ProfileAppbar> createState() => _ProfileAppbarState();
}

class _ProfileAppbarState extends State<ProfileAppbar> {
  ProfileModel? profileModel;
  var imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProfileBloc>(
      context,
    ).add(GetProfileEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
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

          return Container(
            //color: Colors.red,
            height: height(context) / 3,
            child: Stack(
              fit: StackFit.loose,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  height: height(context) / 4.5,
                  decoration: BoxDecoration(
                    color: MyColors.blue,
                    // border: Border.all(
                    //     //color: Color.fromARGB(255, 192, 190, 190)),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(
                        30,
                      ),
                      bottomRight: Radius.circular(
                        30,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          0.1,
                        ),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: widget.isEdit
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          '${Constants.imgPath}back_arrow.png',
                        ),
                      ),
                      Spacer(),
                      Text(
                        !widget.isEdit ? 'Profile' : 'Edit Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ProfileEditPage(),
                              ));
                        },
                        behavior: HitTestBehavior.translucent,
                        child: !widget.isEdit
                            ? Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Image.asset(
                                  '${Constants.imgPath}edit.png',
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: height(context) / 5.3,
                    width: width(context) / 5.2,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(state.profile.image),
                        )),
                  ),
                ),
                widget.isEdit
                    ? Positioned(
                        top: 152,
                        left: 141,
                        right: 141,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              showAlertDialog(context);
                            },
                            child: Container(
                              height: height(context) / 10,
                              width: width(context) / 13,
                              decoration: BoxDecoration(
                                //shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                      '${Constants.imgPath}camera.png'),

                                  ///fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ))
                    : Container(),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = XFile(pickedFile.path);
      BlocProvider.of<UpdateImageBloc>(context)
          .add(UpdateProfileImageEvent(context: context, image: imageFile));
    }
  }

  _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = XFile(pickedFile.path);
        BlocProvider.of<UpdateImageBloc>(context)
            .add(UpdateProfileImageEvent(context: context, image: imageFile));
      });
    }
  }

  showAlertDialog(
    BuildContext context,
  ) {
    Widget cameraButton = TextButton(
      child: Text("CAMERA"),
      onPressed: () {
        _getFromCamera();
        Navigator.pop(context);
      },
    );
    Widget galleryButton = TextButton(
      child: Text("GALLERY"),
      onPressed: () {
        _getFromGallery();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Select Image From"),
      //content: Text("This is my message."),
      actions: [cameraButton, galleryButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
