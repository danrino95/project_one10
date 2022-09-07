import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:typroject/Screens/email_verify.dart';

import '../providers/internet_provider.dart';
import '../providers/sign_in_provider.dart';
import '../utils/next_screen.dart';
import '../utils/snack_bar.dart';
import 'home_screen.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name Cannot Be Empty";
                  }
                  return null;
                },
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Enter Name'),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Enter Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Enter Valid Email"
                        : null,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Enter Password'),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? "Enter Valid Password"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text("Register"))
            ],
          ),
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
