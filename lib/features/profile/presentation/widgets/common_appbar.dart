import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CommonAppbar extends StatefulWidget {
  const CommonAppbar({Key? key}) : super(key: key);

  @override
  State<CommonAppbar> createState() => _CommonAppbarState();
}

class _CommonAppbarState extends State<CommonAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 30, left: 20),
      child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              '${Constants.imgPath}back_arrow.png',
            ),
          )),
    );
  }
}
