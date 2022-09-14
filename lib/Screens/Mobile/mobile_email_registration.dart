import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:typroject/Screens/email_verify.dart';

import '../../providers/internet_provider.dart';
import '../../providers/sign_in_provider.dart';
import '../../utils/next_screen.dart';
import '../../utils/snack_bar.dart';
import '../../providers/internet_provider.dart';
import '../../providers/sign_in_provider.dart';
import '../../utils/next_screen.dart';
import '../../utils/snack_bar.dart';
import '../home_screen.dart';

class EmailRegistrationMobile extends StatefulWidget {
  const EmailRegistrationMobile({Key? key}) : super(key: key);

  @override
  State<EmailRegistrationMobile> createState() => _EmailRegistrationMobileState();
}

class _EmailRegistrationMobileState extends State<EmailRegistrationMobile> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

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
                    bottomLeft: Radius.circular(300),
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
                    "Email Registration",
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
                        topRight: Radius.circular(180),
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
                                decoration: const InputDecoration(border: InputBorder.none,labelText: 'Enter Name'),
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
                                controller: emailController,
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
                                  onPressed: signIn,
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

  Future signIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      // ignore: use_build_context_synchronously
      openSnackBar(context, "Check your Internet connection", Colors.red);
    } else {
      if (formkey.currentState!.validate()) {
        try {
          User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()))
              .user!;
          sp.emailUser(user, emailController.text, nameController.text,
              passwordController.text);
          sp.saveDataToFirestore().then((value) => sp
              .saveDataToSharedPreferences()
              .then((value) => sp.setSignIn().then((value) {
            nextScreenReplace(context, const VerifyEmailScreen());
          })));
        } on FirebaseAuthException catch (e) {
          // ignore: avoid_print
          print(e);

          // ignore: use_build_context_synchronously
          openSnackBar(context, e.toString(), Colors.red);
        }
      }
    }
  }
}
