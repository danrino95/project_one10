import 'package:custom_gradient_button/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:typroject/Screens/Mobile/gov_auth.dart';
import 'package:typroject/Screens/Mobile/mobile_email_phone_signin.dart';
import 'package:typroject/Screens/Mobile/mobile_email_registration.dart';
import 'package:typroject/Screens/Mobile/mobile_phone_registration.dart';
import 'package:typroject/Screens/Mobile/mobile_social_sign_in.dart';

import '../../utils/next_screen.dart';
import '../get_started.dart';

class GettingStartedMobile extends StatefulWidget {
  const GettingStartedMobile({Key? key}) : super(key: key);

  @override
  State<GettingStartedMobile> createState() => _GettingStartedMobileState();
}

class _GettingStartedMobileState extends State<GettingStartedMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              "Getting Started",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 100),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrange,
            ),
            width: MediaQuery.of(context).size.width * 1,
            height: 250,
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: Color(0XFFED213A),
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0XFFA8A8A8A8A8A8),
                      offset: Offset(5, 5),
                      blurRadius: 20,
                      spreadRadius: 0
                  ),

                ]
            ),
            child: Center(child: ElevatedButton(
                onPressed: () {
                  nextScreenReplace(
                      context, const EmailPhoneSignInMobile());
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onSurface: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Already Have an Account? LogIn.."))
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            child: Text(
              "Haven’t Registered Yet?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  nextScreenReplace(
                      context, const EmailRegistrationMobile());
                },
                child: Text("Email"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  nextScreenReplace(
                      context, const PhoneRegistrationMobile());
                },
                child: Text("Phone"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  nextScreenReplace(
                      context, const gov_auth());
                },
                child: Text("Phone"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          Container(

            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(60),
                topLeft: Radius.circular(60),
              ),
              color: Colors.deepOrange,
            ),
            width: MediaQuery.of(context).size.width * 1,
            height: 250,

            child:Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Try One Click SignIn/SignUp ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),

                ElevatedButton(
                  onPressed: () {
                    nextScreenReplace(
                        context, const SocialSignInMobile());
                  },
                  style: ElevatedButton.styleFrom(

                    primary: Color(0xfff0f0f0),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  child: const Text("Click",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
