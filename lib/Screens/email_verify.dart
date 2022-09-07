import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:typroject/Screens/home_screen.dart';

import '../providers/sign_in_provider.dart';
import '../utils/snack_bar.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final RoundedLoadingButtonController emailVerifyController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController cancleController =
      RoundedLoadingButtonController();

  bool isEmailVerified = false;
  bool canRsendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canRsendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canRsendEmail = true);
    } catch (e) {
      openSnackBar(context, e.toString(), Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.read<SignInProvider>();
    if (isEmailVerified == true) {
      return HomeScreen();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Verify Email'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Verify Email Sent"),
            const SizedBox(
              height: 18,
            ),
            RoundedLoadingButton(
              controller: emailVerifyController,
              onPressed: () {
                if (canRsendEmail == true) {
                  sendVerificationEmail();
                }

                // nextScreenReplace(context, const HomeScreen());
                // emailVerifyController.reset();
              },
              successColor: Colors.black,
              color: Colors.black,
              width: MediaQuery.of(context).size.width * 0.80,
              elevation: 0,
              borderRadius: 25,
              child: Wrap(
                children: const [
                  Icon(
                    FontAwesomeIcons.addressBook,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Email Sent",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            RoundedLoadingButton(
              controller: cancleController,
              onPressed: () {
                sp.userEmailSignOut();
                cancleController.reset();
              },
              successColor: Colors.black,
              color: Colors.black,
              width: MediaQuery.of(context).size.width * 0.80,
              elevation: 0,
              borderRadius: 25,
              child: Wrap(
                children: const [
                  Icon(
                    FontAwesomeIcons.addressBook,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Cancle",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          ]),
        ),
      );
    }
  }
}
