import 'package:clean_app_sample/core/material/colors.dart';
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
    return AppBar(
      backgroundColor: MyColors.blue,
      automaticallyImplyLeading: true,
    );
  }
}
