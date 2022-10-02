import 'package:flutter/material.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({Key? key}) : super(key: key);

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          "Home",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 100),
        ),
      ),
    );
  }
}
