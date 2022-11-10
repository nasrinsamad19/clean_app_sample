import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:clean_app_sample/features/home/presentation/widgets/home_card.dart';
import 'package:clean_app_sample/features/home/presentation/widgets/navigationbar.dart';
import 'package:clean_app_sample/features/login/presentation/pages/login_page.dart';
import 'package:clean_app_sample/features/users/presentation/pages/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 40,
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: MyColors.blue,
          // leading: IconButton(
          //   color: Colors.white,
          //   icon: const Icon(
          //     Icons.search,
          //   ),
          //   onPressed: () async {},
          // ),
          // actions: [
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           IconButton(
          //             color: Colors.white,
          //             icon: const Icon(
          //               Icons.notifications_none_outlined,
          //             ),
          //             onPressed: () async {},
          //           ),
          //           SizedBox(
          //               //width: width(context) * .07,
          //               )
          //         ],
          //       ),
          //     ],
          //   )
          // ],
          // bottom: PreferredSize(
          //     child:
          //     preferredSize: Size.zero),
        ),

        ///Old code
        ///
        ///
        //     body: Container(
        //   decoration: const BoxDecoration(
        //     color: Color.fromARGB(255, 4, 60, 105),
        //   ),
        //   child: Align(
        //       alignment: Alignment.center,
        //       child: Container(
        //         height: 50,
        //         width: 50,
        //         color: Colors.white,
        //         child: GestureDetector(
        //           child: Text('USERS'),
        //           onDoubleTap: () {
        //             Navigator.pushReplacement(
        //               context,
        //               MaterialPageRoute<void>(
        //                 builder: (BuildContext context) => const UsersPage(),
        //               ),
        //             );
        //           },
        //         ),
        //       )),
        // )
        backgroundColor: Color.fromARGB(255, 234, 233, 233),
        body: Center(child: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      height: height(context) / 4,
                      width: width(context),
                      padding: EdgeInsets.only(top: 10, left: 30),
                      color: MyColors.blue,
                    ),
                    Container(
                      color: MyColors.yellow,
                      width: width(context),
                      height: height(context) * .05,
                    ),
                  ],
                )),
            Positioned(
                top: 5,
                right: -width(context) * .4,
                child: Image(
                  image: AssetImage(
                    '${Constants.imgPath}whiteCar.png',
                  ),
                  fit: BoxFit.contain,
                )),
            Positioned(
              top: 100,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Enjoy discovering',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text('Limitless Parking',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          //top: 300,
          child: HomeCard(),
        )
      ],
    );
  }
}
