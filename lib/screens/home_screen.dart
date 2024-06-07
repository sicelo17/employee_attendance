import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<IconData> navigationIcons = [
    FontAwesomeIcons.solidCalendarDays,
    FontAwesomeIcons.check,
    FontAwesomeIcons.solidUser,
  ];

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("Home Screen and see what you can do with it!!"),
      ),

      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(left: 20, right: 12, bottom: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(2, 2),
            ),
    ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      for(int i =0; i < navigationIcons.length; i++)...{
        Expanded(
        child: GestureDetector(
          onTap: (){
            setState(() {
              currentIndex = i;
            });
          },
            child: Center(child: FaIcon(navigationIcons[i],
            color: i == currentIndex ? Colors.redAccent : Colors.black54,
              size: i == currentIndex ? 30 : 24,
            ),))
        )
    }

    ],
      ),
    ));
  }
}