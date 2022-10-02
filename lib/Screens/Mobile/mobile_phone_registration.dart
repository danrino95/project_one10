import 'package:typroject/providers/internet_provider.dart';
import 'package:typroject/providers/sign_in_provider.dart';
import '../home_screen.dart';
import 'package:typroject/utils/next_screen.dart';
import 'package:typroject/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class PhoneRegistrationMobile extends StatefulWidget {
  const PhoneRegistrationMobile({Key? key}) : super(key: key);

  @override
  State<PhoneRegistrationMobile> createState() =>
      _PhoneRegistrationMobileState();
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
        body: Center(
            child: Container(
                child: SingleChildScrollView(
                    child: ResponsiveGridRow(children: [
                      ResponsiveGridCol(                                    //background
                        lg: 12,
                        child: Container(
                          padding: EdgeInsets.only(left: 8,top: 5),
                          height: 130,
                          alignment: Alignment(-1,0),
                          color: Color(0xff122333),
                          child: SizedBox(
                            height:40,width: 50,
                            child:ElevatedButton(
                              child: Text('<',
                                style: TextStyle(fontSize: 30, color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff2FAC69),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
      ResponsiveGridCol(
          //logo
          lg: 12,
          child: Container(
              height: 240,
              alignment: Alignment(0, 0),
              color: Color(0xff122333),
              child: Image.asset('Assets/Images/AtelierSpot.png',
                  height: 600, width: 600))),
      ResponsiveGridCol(
        //text
        lg:12,
        child: Container(
            height: 40,
            alignment: Alignment(-1, 1),
            color: Color(0xff122333),
            child:const Padding(
              padding: EdgeInsets.only(left: 60,bottom:3),
              child: Text(
                'Enter Name',
                style: TextStyle(fontSize: 20, color: Colors.white) ,
              ),
            )
        ),
      ),
                      ResponsiveGridCol(                           //inputfield
                        lg: 12,
                        child: Container(
                            height: 75,
                            alignment: Alignment(0, 0),
                            color: Color(0xff122333),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)
                              ),
                              elevation: 5,
                              shadowColor: Colors.white,
                              child:SizedBox(
                                width: 350,
                                height:60,
                                child:  Padding(
                                  padding: EdgeInsets.only(left: 35,right:35,top: 10,bottom: 15),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Name Cannot Be Empty";
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: 'abc',
                                    ),
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                      ResponsiveGridCol(
                        //text
                        lg:200,
                        child: Container(
                            height: 40,
                            alignment: Alignment(-1, 1),
                            color: Color(0xff122333),
                            child:const Padding(
                              padding: EdgeInsets.only(left: 60,bottom:3),
                              child: Text(
                                'Enter Phone Number',
                                style: TextStyle(fontSize: 20, color: Colors.white) ,
                              ),
                            )
                        ),
                      ),
      ResponsiveGridCol(
        //inputfield
        lg: 12,
        child: Container(
            height: 75,
            alignment: Alignment(0, 0),
            color: Color(0xff122333),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              elevation: 5,
              shadowColor: Colors.yellow,
              child: SizedBox(
                width: 350,
                height: 60,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name Cannot Be Empty";
                      }
                      return null;
                    },
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: '+91 0123456789',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            )),
      ),
                      ResponsiveGridCol(                                    //background
                        lg: 12,
                        child: Container(
                          padding: EdgeInsets.only(left:130),
                          height: 139,
                          alignment: Alignment(-1,0),
                          color: Color(0xff122333),
                          child: SizedBox(
                            height:40,width: 150,
                            child:ElevatedButton(
                              child: Text('Next',
                                style: TextStyle(fontSize: 25, color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff2FAC69),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )
                              ),
                              onPressed: () {
                                login(context, phoneController.text.trim());
                              },
                            ),
                          ),
                        ),
                      ),
      ResponsiveGridCol(
          //background
          lg: 12,
          child: Container(
            height: 130,
            alignment: Alignment(0, 0),
            color: Color(0xff122333),
          )),
    ])))));
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
                              child: const Text("Confirm"))
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
