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

import 'emailauth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 90, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name Cannot Be Empty";
                                }
                                return null;
                              },
                              controller: nameController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  labelText: 'Enter Name'),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: emailauthController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  labelText: 'Enter Email'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? "Enter Valid Email"
                                  : null,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: passwordController,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                  labelText: 'Enter Passsword'),
                              obscureText: true,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? "Enter Valid Password"
                                      : null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: signIn,
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  child: const Text("SignIn"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      nextScreenReplace(
                                          context, const EmailAuthScreen());
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    child: const Text("SignUp"))
                              ],
                            )
                          ],
                        ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    const SizedBox(
                      height: 10,
                    ),

                    RoundedLoadingButton(
                      controller: phoneController,
                      onPressed: () {
                        nextScreenReplace(context, const PhoneAuthScreen());
                        phoneController.reset();
                      },
                      successColor: Colors.black,
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width * 0.80,
                      elevation: 0,
                      borderRadius: 25,
                      child: Wrap(
                        children: const [
                          Icon(
                            FontAwesomeIcons.phone,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Sign in with Phone",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedLoadingButton(
                      controller: phoneController,
                      onPressed: () {
                        nextScreenReplace(context, const getting_started());
                      },
                      successColor: Colors.black,
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width * 0.80,
                      elevation: 0,
                      borderRadius: 25,
                      child: Wrap(
                        children: const [
                          Icon(
                            FontAwesomeIcons.phone,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Getting Started",
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
              ],
            ),
          ),
        ));
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
