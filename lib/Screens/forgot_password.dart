import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {

  final _emailController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());

      showDialog(context: context, builder: (context){
        return const AlertDialog(
          content: Text('Password reset link sent! Check Your Email'),
        );
      });
    } on FirebaseAuthException catch (e){

      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text('Password Reset Link Will be send to your email once you submit a valid email'
              , textAlign: TextAlign.center,),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Enter Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                value != null
                    ? "Enter Valid Email"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () { passwordReset() ;},
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text("Reset Password"))
            ],
          ),
        ),
      ),
    );
  }

}