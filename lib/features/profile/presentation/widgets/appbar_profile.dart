import 'dart:io';
import 'dart:ui';

import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/home/presentation/pages/home.dart';
import 'package:clean_app_sample/features/profile/data/model/profile_model.dart';
import 'package:clean_app_sample/features/profile/domain/entities/profile.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/bloc/update_image/update_image_bloc.dart';
import 'package:clean_app_sample/features/profile/presentation/pages/profilePage.dart';
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
  var profile;
  var imageFile;
  XFile? image;

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
          return Center(child: Text(state.message));
        }
        if (state is LoadingGetProfileState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is SuccessGetProfileState) {
          if (state.profile.username.isEmpty) {
            return const Center(
              child: Text("No Profile"),
            );
          } else {
            profile = state.profile;
            return Container(
              height: height(context) / 2.7,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    /// padding: EdgeInsets.only(left: 30, right: 30),
                    height: height(context) / 4.5,
                    decoration: BoxDecoration(
                      color: MyColors.blue,
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
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: height(context) / 7,
                        padding: !widget.isEdit
                            ? EdgeInsets.only(top: 30, right: 30, left: 30)
                            : EdgeInsets.only(top: 20, right: 30, left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.isEdit
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ProfilePage()))
                                    : Navigator.pop(context);
                              },
                              child: Image.asset(
                                '${Constants.imgPath}back_arrow.png',
                              ),
                            ),
                            Text(
                              !widget.isEdit ? 'Profile' : 'Edit Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          ProfileEditPage(
                                        profile: profile,
                                      ),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Image.asset(
                                        '${Constants.imgPath}edit.png',
                                      ),
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      )),
                  Stack(
                    children: [
                      Positioned(
                        top: 90,
                        left: 30,
                        right: 30,
                        child: Container(
                          height: height(context) / 5.3,
                          width: width(context) / 5.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: imageFile == null
                                  ? DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(state.profile.image),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(image!.path)),
                                    )),
                        ),
                      ),
                      widget.isEdit
                          ? Positioned(
                              bottom: 24,
                              left: 141,
                              right: 141,
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showAlertDialog(context);
                                },
                                child: Container(
                                  height: height(context) / 9,
                                  width: width(context) / 5.3,
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
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = XFile(pickedFile.path);
        print(pickedFile.path);
        image = XFile(pickedFile.path);
        BlocProvider.of<UpdateImageBloc>(context)
            .add(UpdateProfileImageEvent(context: context, image: imageFile));
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = XFile(pickedFile.path);
        print(imageFile);
        image = XFile(pickedFile.path);
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
