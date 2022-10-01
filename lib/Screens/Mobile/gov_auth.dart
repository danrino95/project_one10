import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:govt_documents_validator/govt_documents_validator.dart';
import 'package:typroject/Screens/Mobile/mobile_geo_location.dart';

import '../../utils/next_screen.dart';

class gov_auth extends StatefulWidget {
  const gov_auth({Key? key}) : super(key: key);

  @override
  State<gov_auth> createState() => _gov_authState();
}

class _gov_authState extends State<gov_auth> {
  var _formKey = GlobalKey<FormState>();
  late bool isAadharNum;
  late bool isGSTNum;
  late bool isPAnNum;
  PANValidator panValidator = new PANValidator();
  GSTValidator gstValidator = new GSTValidator();
  AadharValidator aadharValidator = new AadharValidator();
  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Document Validation",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLength: 12,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: 'Aadhar Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onFieldSubmitted: (value) {},
                validator: (value) {
                  if (aadharValidator.validate(value) == true) {
                    return "aadhar true";
                  }
                  return "Incorrect Aadhar Number";
                },
              ),
              //box styling
              SizedBox(
                height: 30,
              ),
              //text input
              TextFormField(
                maxLength: 15,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: 'GST Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onFieldSubmitted: (value) {},
                validator: (value) {
                  if (gstValidator.validate(value) == true) {
                    return "gst true";
                  }
                  return "Incorrect GST Number";
                },
              ),
              //box styling
              SizedBox(
                height: 30,
              ),
          TextFormField(
            maxLength: 15,
            cursorColor: Colors.green,
            decoration: InputDecoration(
              labelText: 'PAN Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            onFieldSubmitted: (value) {},
            validator: (value) {
              if (panValidator.validate(value) == true) {
                return "Pan true";
              }
              return "Incorrect Pan Number";
            },
          ),
          //box styling
          SizedBox(
            height:30,
          ),
              //text input
              ElevatedButton(

                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () => _submit(),
              ),
              ElevatedButton(
                onPressed: () {
                  nextScreenReplace(
                      context, const GeoLocationMobile());
                },
                child: Text("Email"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isAadharNum', isAadharNum));
  }
}
