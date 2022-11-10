import 'package:clean_app_sample/core/material/colors.dart';
import 'package:clean_app_sample/core/material/constants.dart';
import 'package:clean_app_sample/core/util/screen_constarints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  final List itemList = [
    [
      '${Constants.imgPath}my_vehicles.png',
      'My Vehices',
      'Operation on my vehicles'
    ],
    ['${Constants.imgPath}reserved.png', 'Reserve', 'Make New Reservation'],
    [
      '${Constants.imgPath}tracking.png',
      'Find My Car',
      'Get Your Car Location'
    ],
    ['${Constants.imgPath}search.png', 'My Trips', 'View Trips History'],
    [
      '${Constants.imgPath}future_reservation.png',
      'Reservations',
      'Thanks for using Limitless Park'
    ],
    [
      '${Constants.imgPath}car_wash.png',
      'Car wash',
      'View Trips History',
    ],
    ['${Constants.imgPath}petrol.png', 'Car Fuel', 'View Trips History'],
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Color.fromARGB(255, 248, 245, 245),
        padding: EdgeInsets.only(top: 150, left: 16, right: 25),
        child: GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 10),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Positioned(
                    top: 20,
                    left: 6,
                    // right: 30,
                    child: Container(
                      height: height(context) * .1,

                      //padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
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
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      width: width(context) * .38,
                      //height: height(context) * .4,
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemList[index][1],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                color: MyColors.font,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 4,
                        ),
                        Text(itemList[index][2],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              color: MyColors.font,
                            )),
                      ],
                    ),
                  ),
                  Positioned(
                      top: -20,
                      right: -22,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image(
                          image: AssetImage(itemList[index][0]),
                          fit: BoxFit.contain,
                        ),
                      )),
                ],
              ),
              // color: Color.fromARGB(255, 211, 194, 193),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            //mainAxisSpacing: 8,
            //crossAxisSpacing: 8,
            childAspectRatio: 2,
          ),
        ));
  }
}
