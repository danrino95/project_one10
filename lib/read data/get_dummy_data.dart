
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDummyData extends StatelessWidget{
  final String documentId;

  GetDummyData({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // get collection
    CollectionReference dummyData = FirebaseFirestore.instance.collection('dummyData');

    return FutureBuilder<DocumentSnapshot>(
      future: dummyData.doc(documentId).get(),
        builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
        snapshot.data!.data() as Map<String, dynamic>;
        return Text('${data['category']}' + ' ' + '${data['service']}' + ' ' + '${data['price']}');
      }
      return Text('Loading....');
        }
      ),
    );
  }
}