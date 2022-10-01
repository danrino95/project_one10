import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:typroject/Screens/Mobile/mobile_phone_registration.dart';
import 'package:typroject/Screens/email_verify.dart';

import '../../providers/internet_provider.dart';
import '../../providers/sign_in_provider.dart';
import '../../utils/next_screen.dart';
import '../../utils/snack_bar.dart';
import '../home_screen.dart';

import 'package:typroject/providers/internet_provider.dart';
import 'package:typroject/providers/sign_in_provider.dart';
import 'package:typroject/utils/next_screen.dart';
import 'package:typroject/utils/snack_bar.dart';

class EmailPhoneSignInMobile extends StatefulWidget {
  const EmailPhoneSignInMobile({Key? key}) : super(key: key);

  @override
  State<EmailPhoneSignInMobile> createState() => _EmailPhoneSignInMobileState();
  
}

class _EmailPhoneSignInMobileState extends State<EmailPhoneSignInMobile> {
  final formkey_email = GlobalKey<FormState>();
  TextEditingController emailauthController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final formkey_phone = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(300),
                  ),
                  color: Colors.deepOrange,
                ),
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
            Padding(
              padding: const
              EdgeInsets.only(left: 20, top: 20, bottom: 30, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(180),
                      ),
                      color: Color(0xfff4f7fe),
                    ),
                    width: MediaQuery.of(context).size.width * 1,
                    // height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [

                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: const [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Hello,",
                                style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4.0,
                                        color: Color.fromARGB(150, 150, 150, 150),
                                      ),
                                    ],
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 60),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Welcome Back",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF04A5D),
                                    fontSize: 45),
                              ),
                            ),
                          ],
                        ) ),
                    Form(
                        key: formkey_email,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: const Color(0XFFEFF3F6),
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: const [
                                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1),
                                        offset: Offset(6, 2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0
                                    ),
                                    BoxShadow(
                                        color: Color.fromRGBO(255, 255, 255, 0.9),
                                        offset: Offset(-6, -2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0
                                    )
                                  ]
                              ),
                              child: Padding(padding: const EdgeInsets.only(left:10 ), child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Name Cannot Be Empty";
                                  }
                                  return null;
                                },
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(border: InputBorder.none,labelText: 'Enter Name'),
                              ),
                            ),),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: const Color(0XFFEFF3F6),
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: const [
                                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1),
                                        offset: Offset(6, 2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0
                                    ),
                                    BoxShadow(
                                        color: Color.fromRGBO(255, 255, 255, 0.9),
                                        offset: Offset(-6, -2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0
                                    )
                                  ]
                              ),
                              child:
                              Padding(padding: const EdgeInsets.only(left:10 ), child:
                              TextFormField(
                                controller: emailauthController,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(border: InputBorder.none,labelText: 'Enter Email'),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? "Enter Valid Email"
                                    : null,
                              ),
                            ),),

                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: const Color(0XFFEFF3F6),
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: const [
                                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1),
                                        offset: Offset(6, 2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0
                                    ),
                                    BoxShadow(
                                        color: Color.fromRGBO(255, 255, 255, 0.9),
                                        offset: Offset(-6, -2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0
                                    )
                                  ]
                              ),
                              child: Padding(padding: const EdgeInsets.only(left:10 ),
                                child: TextFormField(
                                  controller: passwordController,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(border: InputBorder.none,labelText: 'Enter Password'),
                                  obscureText: true,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) => value != null && value.length < 6
                                      ? "Enter Valid Password"
                                      : null,
                                ),
                              )


                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  color: const Color(0XFFED213A),
                                  borderRadius: BorderRadius.circular(100.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0XFFA8A8A8),
                                        offset: Offset(5, 5),
                                        blurRadius: 20,
                                        spreadRadius: 0
                                    ),

                                  ]
                              ),
                              child: Center(child: ElevatedButton(
                                  onPressed: signIn,
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    onSurface: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: const Text("Login1"))
                              ),
                            ),
                          ],
                        ),
                      ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Phone Registration",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 60),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                            ),
                            color: Color(0xfff4f7fe),
                          ),
                          width: MediaQuery.of(context).size.width * 1,
                          // height: MediaQuery.of(context).size.height * 0.5,
                          child: Column(
                            children: [
                              Form(
                                key: formkey_phone,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 100,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      decoration: BoxDecoration(
                                          color: const Color(0XFFEFF3F6),
                                          borderRadius: BorderRadius.circular(100.0),
                                          boxShadow: const [
                                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1),
                                                offset: Offset(6, 2),
                                                blurRadius: 6.0,
                                                spreadRadius: 3.0
                                            ),
                                            BoxShadow(
                                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                                offset: Offset(-6, -2),
                                                blurRadius: 6.0,
                                                spreadRadius: 3.0
                                            )
                                          ]
                                      ),
                                      child: Padding(padding: const EdgeInsets.only(left:10 ),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "PhoneNumber Cannot Be Empty";
                                            }
                                            return null;
                                          },
                                          controller: phoneController,
                                          textInputAction: TextInputAction.done,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: Icon(Icons.phone),
                                            hintText: "+91 1234567890",
                                            hintStyle:
                                            TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFFED213A),
                                          borderRadius: BorderRadius.circular(100.0),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color(0XFFA8A8A8),
                                                offset: Offset(5, 5),
                                                blurRadius: 20,
                                                spreadRadius: 0
                                            ),
                                          ]
                                      ),
                                      child: Center(child: ElevatedButton(
                                          onPressed: () {
                                            login(context, phoneController.text.trim());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.transparent,
                                            onSurface: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)),
                                          ),
                                          child: const Text("Login"))
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
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

  Future signIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
    } else {
      if (formkey_email.currentState!.validate()) {
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

  Future login(BuildContext context, String mobile) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
    } else {
      if (formkey_phone.currentState!.validate()) {
        FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: mobile,
            verificationCompleted: (AuthCredential credential) async {
              await FirebaseAuth.instance.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              openSnackBar(context, e.toString(), Colors.red);
            },
            codeSent: (verificationId, forceResendingToken) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Enter Code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: otpCodeController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.code),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                  const BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                  const BorderSide(color: Colors.grey)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 0, 0)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final code = otpCodeController.text.trim();
                                AuthCredential authCredential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: code);
                                User user = (await FirebaseAuth.instance
                                    .signInWithCredential(authCredential))
                                    .user!;
                                sp.phoneNumberUserSignin(user);
                                sp.checkUserExist().then((value) async {
                                  if (value == true) {
                                    await sp
                                        .getUsesDataFromFirestore(sp.uid)
                                        .then((value) => sp
                                        .saveDataToSharedPreferences()
                                        .then((value) =>
                                        sp.setSignIn().then((value) {
                                          nextScreenReplace(context,
                                              const HomeScreen());
                                        })));
                                  } else {
                                    nextScreenReplace(
                                        context, const PhoneRegistrationMobile());
                                  }
                                });
                              },
                              child: const Text("Confiirm"))
                        ],
                      ),
                    );
                  });
            },
            codeAutoRetrievalTimeout: (String verification) {});
      }
    }
  }
}
