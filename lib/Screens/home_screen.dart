import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typroject/Screens/dummydata_crud_screen.dart';
import 'package:typroject/Screens/login_screen.dart';
import 'package:typroject/providers/sign_in_provider.dart';
import 'package:typroject/read%20data/get_dummy_data.dart';
import 'package:typroject/utils/next_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSP();
  }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  //
  // }

  // document IDs
  List<String> docIDs = [];

  // get docIDs and store it in docID
  Future getDocId() async{
    docIDs.clear();
    await FirebaseFirestore.instance
        .collection('dummyData')
        .orderBy('price', descending: priceSort)
        .where('category', )
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((element) {
          docIDs.add(element.reference.id);
      }),
    );

  }

  bool priceSort = false;


  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome ${sp.name}",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if ("${sp.provider}" == "EMAIL") {
                sp.userEmailSignOut();
              } else {
                sp.userSignOut();
              }
              nextScreenReplace(context, const LoginScreen());
            },
              child: Icon(Icons.logout)
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              onPressed: () {
                nextScreenReplace(context, const DummyDataCrud());
              },
              child: const Text(
                "Add Dummy Data",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                    setState(() => priceSort = !priceSort);
              },
              child: const Text(
                "Sort By Price: High - Low",
                style: TextStyle(color: Colors.white),
              ),
            ),

            Expanded(
                child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.grey,
                            title: GetDummyData(documentId: docIDs[index]),
                          ),
                        );
                      },
                    );
                  }),
                ),



          ],
        ),
      ),
    );
  }
}
