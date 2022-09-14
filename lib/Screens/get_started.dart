import 'package:flutter/material.dart';
import 'package:typroject/Screens/Desktop/desktop_getting_started.dart';
import 'package:typroject/Screens/Mobile/mobile_getting_started.dart';
import 'package:typroject/Screens/responsive.dart';

class getting_started extends StatefulWidget {
  const getting_started({Key? key}) : super(key: key);

  @override
  State<getting_started> createState() => _getting_startedState();
}

class _getting_startedState extends State<getting_started> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: responsiveLayout(
            mobileBody: GettingStartedMobile(),
            desktopBody: GettingStartedDesktop())
    );
  }
}
