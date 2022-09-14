import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:typroject/Screens/email_verify.dart';
import 'package:typroject/Screens/get_started.dart';
import 'package:typroject/Screens/home_screen.dart';
import 'package:typroject/Screens/phoneauth_screen.dart';
import 'package:typroject/providers/internet_provider.dart';
import 'package:typroject/providers/sign_in_provider.dart';
import 'package:typroject/utils/config.dart';
import 'package:typroject/utils/next_screen.dart';
import 'package:typroject/utils/snack_bar.dart';
import 'package:email_validator/email_validator.dart';

import '../emailauth_screen.dart';

class SocialSignInMobile extends StatefulWidget {
  const SocialSignInMobile({Key? key}) : super(key: key);

  @override
  State<SocialSignInMobile> createState() => _SocialSignInMobileState();
}

class _SocialSignInMobileState extends State<SocialSignInMobile> {
  final formkey = GlobalKey<FormState>();
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController twitterController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController phoneController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController emailController =
      RoundedLoadingButtonController();

  TextEditingController emailauthController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  //
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(200),
                  ),
                  color: Colors.deepOrange,
                ),
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 1.0,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, top: 30, bottom: 30, right: 20),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                      ),
                      color: Color(0xfff4f7fe),
                    ),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        const Text(
                          "Social Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF14A5C),
                              fontSize: 40),
                        ),
                        const SizedBox(
                          height: 30,
                          child: const DecoratedBox(
                            decoration: const BoxDecoration(color: Colors.red),
                          ),
                        ),
                        RoundedLoadingButton(
                          controller: googleController,
                          onPressed: () {
                            handleGoogleSignIn();
                          },
                          successColor: Color.fromARGB(255, 138, 138, 138),
                          color: Color.fromARGB(255, 117, 117, 117),
                          width: MediaQuery.of(context).size.width * 0.80,
                          elevation: 0,
                          borderRadius: 25,
                          child: Wrap(
                            children: [
                              Image(
                                image: AssetImage(Config.google),
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //  Facebook
                        RoundedLoadingButton(
                          controller: facebookController,
                          onPressed: () {
                            handleFacebookAuth();
                          },
                          successColor: Colors.blue,
                          color: Colors.blue,
                          width: MediaQuery.of(context).size.width * 0.80,
                          elevation: 0,
                          borderRadius: 25,
                          child: Wrap(
                            children: const [
                              Icon(
                                FontAwesomeIcons.facebook,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Sign in with Facebook",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Twitter
                        RoundedLoadingButton(
                          controller: twitterController,
                          onPressed: () {
                            handleTwitterAuth();
                          },
                          successColor: Colors.lightBlue,
                          color: Colors.lightBlue,
                          width: MediaQuery.of(context).size.width * 0.80,
                          elevation: 0,
                          borderRadius: 25,
                          child: Wrap(
                            children: const [
                              Icon(
                                FontAwesomeIcons.twitter,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Sign in with Twitter",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//google
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackBar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          sp.checkUserExist().then((value) async {
            if (value == true) {
              await sp.getUsesDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handelAfterSignIn();
                      })));
            } else {
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handelAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

//facebook
  Future handleFacebookAuth() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
      facebookController.reset();
    } else {
      await sp.signInWithFacebook().then((value) {
        if (sp.hasError == true) {
          openSnackBar(context, sp.errorCode.toString(), Colors.red);
          facebookController.reset();
        } else {
          sp.checkUserExist().then((value) async {
            if (value == true) {
              await sp.getUsesDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handelAfterSignIn();
                      })));
            } else {
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handelAfterSignIn();
                      })));
            }
          });
        }
      });
    }

//internet Provider
  }

// Twitter
  Future handleTwitterAuth() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
      twitterController.reset();
    } else {
      await sp.signInWithTwitter().then((value) {
        if (sp.hasError == true) {
          openSnackBar(context, sp.errorCode.toString(), Colors.red);
          twitterController.reset();
        } else {
          sp.checkUserExist().then((value) async {
            if (value == true) {
              await sp.getUsesDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        twitterController.success();
                        handelAfterSignIn();
                      })));
            } else {
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        twitterController.success();
                        handelAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  Future signIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
    } else {
      if (formkey.currentState!.validate()) {
        try {
          User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailauthController.text.trim(),
                  password: passwordController.text.trim()))
              .user!;
          sp.emailUser(user, emailauthController.text, nameController.text,
              passwordController.text);
          sp.emailUser(user, emailauthController.text, nameController.text,
              passwordController.text);
          sp.checkUserExist().then((value) async {
            if (value == true) {
              await sp.getUsesDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        nextScreenReplace(context, const VerifyEmailScreen());
                      })));
            }
          });
        } on FirebaseAuthException catch (e) {
          // ignore: avoid_print
          print(e);

          // ignore: use_build_context_synchronously
          openSnackBar(context, e.toString(), Colors.red);
        }
      }
    }
  }

//
  handelAfterSignIn() {
    Future.delayed(const Duration(microseconds: 1000)).then((value) {
      nextScreenReplace(context, const HomeScreen());
    });
  }
}
