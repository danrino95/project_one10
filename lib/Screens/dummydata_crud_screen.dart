import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:typroject/Screens/home_screen.dart';

import '../utils/next_screen.dart';

class DummyDataCrud extends StatefulWidget {
  const DummyDataCrud({Key? key}) : super(key: key);

  @override
  State<DummyDataCrud> createState() => _DummyDataCrud();
}

class _DummyDataCrud extends State<DummyDataCrud> {

  final _catController = TextEditingController();
  final _serviceController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose(){
    _catController.dispose();
    _serviceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future sendData() async{
    addData(
        _catController.text.trim(),
        _serviceController.text.trim(),
        int.parse(_priceController.text.trim(),)
    );
  }

  Future addData(
      String cat, String service, int price) async{
    await FirebaseFirestore.instance.collection('dummyData').add({
      'category': cat,
      'service': service,
      'price': price,
    });

    showDialog(context: context, builder: (context){
      return const AlertDialog(
        content: Text('Data Added'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                nextScreenReplace(context, const HomeScreen());
              },
              child: Icon(Icons.logout)
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text('Enter Dummy Data'
                , textAlign: TextAlign.center,),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _catController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Enter Category of the Service'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                value != null
                    ? "Enter Valid Category"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _serviceController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Enter name of the Service'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                value != null
                    ? "Enter Valid Service Name"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _priceController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Enter Price'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                value != null
                    ? "Enter Valid Price"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () { sendData();},
                  style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  child: const Text("Create"))
            ],
          ),
        ),
      ),
    );
  }

}