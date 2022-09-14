import 'package:typroject/providers/internet_provider.dart';
import 'package:typroject/providers/sign_in_provider.dart';
import '../home_screen.dart';
import '../login_screen.dart';
import 'package:typroject/utils/config.dart';
import 'package:typroject/utils/next_screen.dart';
import 'package:typroject/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneRegistrationMobile extends StatefulWidget {
  const PhoneRegistrationMobile({Key? key}) : super(key: key);

  @override
  State<PhoneRegistrationMobile> createState() => _PhoneRegistrationMobileState();
}

class _PhoneRegistrationMobileState extends State<PhoneRegistrationMobile> {
  final formkey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(300),
                  ),
                  color: Colors.deepOrange,
                ),
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 20, top: MediaQuery.of(context).size.height * 0.2, bottom: 30, right: 20),
              child: Column(
                children: [
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
                          key: formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    color: Color(0XFFEFF3F6),
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
                                child: Padding(padding: EdgeInsets.only(left:10 ), child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name Cannot Be Empty";
                                    }
                                    return null;
                                  },
                                  controller: nameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.account_circle),
                                    hintText: "Name",
                                    hintStyle:
                                    const TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                                  ),
                                ),
                                ),),
                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                    color: Color(0XFFEFF3F6),
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
                                Padding(padding: EdgeInsets.only(left:10 ), child:
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email Cannot Be Empty";
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: const Icon(Icons.email),
                                    hintText: "Email",
                                    hintStyle:
                                    const TextStyle(color: Color.fromARGB(255, 97, 97, 97)),

                                  ),
                                ),
                                ),),

                              const SizedBox(
                                height: 40,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                      color: Color(0XFFEFF3F6),
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
                                  child: Padding(padding: EdgeInsets.only(left:10 ),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "PhoneNumber Cannot Be Empty";
                                        }
                                        return null;
                                      },
                                      controller: phoneController,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        prefixIcon: const Icon(Icons.phone),
                                        hintText: "+91 1234567890",
                                        hintStyle:
                                        const TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
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
                                      login(context, phoneController.text.trim());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      onSurface: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                    ),
                                    child: const Text("Register"))
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
            ),
          ],

        ),
      ),
    );
  }

  Future login(BuildContext context, String mobile) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
    } else {
      if (formkey.currentState!.validate()) {
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
                                sp.phoneNumberUser(user, emailController.text,
                                    nameController.text);
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
                                    sp.saveDataToFirestore().then((value) => sp
                                        .saveDataToSharedPreferences()
                                        .then((value) =>
                                        sp.setSignIn().then((value) {
                                          nextScreenReplace(
                                              context, const HomeScreen());
                                        })));
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
