import 'package:clean_app_sample/features/users/presentation/pages/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 4, 60, 105),
      ),
      child: Align(
          alignment: Alignment.center,
          child: Container(
            height: 50,
            width: 50,
            color: Colors.white,
            child: GestureDetector(
              child: Text('USERS'),
              onDoubleTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const UsersPage(),
                  ),
                );
              },
            ),
          )),
    ));
  }
}
