import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/side_nav.dart';
import 'package:image_picker/image_picker.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key}) : super(key: key);

  @override
  _ManageProfileState createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  User user = FirebaseAuth.instance.currentUser!;
  CollectionReference usersdata =
      FirebaseFirestore.instance.collection('login_details');

  String? company_name;
  String? designation;
  String? username;

  String imagePath = "";
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('getPlaced'),
      ),
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          child: Center(
              child: Column(children: [
            const SizedBox(height: 8),
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.lightBlue,
              child: IconButton(
                onPressed: () async {
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      imagePath = pickedFile.path;
                    });
                  }
                },
                icon: const Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('login_details')
                  .doc(user.uid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  var output = snapshot.data!.data()!;
                  var displayName = output['name'];
                  var displayCompany = output['Company Name'];
                  var displayDesignation = output['Designation'];
                  return Column(
                      children: [
                    TextFormField(
                      onChanged: (value){
                        if(value == null)
                          {
                            username = output['name'];
                          }
                        else{
                          username = value;
                        }
                      },
                      initialValue: displayName,
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Company',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                            ),
                          ),
                      ),
                      onChanged: (value){
                        company_name = value;
                      },
                      initialValue: displayCompany,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'Designation',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                            ),
                          ),),
                      onChanged: (value){
                        designation = value;
                      },
                      initialValue: displayDesignation,
                    )
                  ]);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
                onPressed: () {
                  Future<void> updateUser() {
                    return usersdata
                        .doc(user.uid)
                        .update({
                          'name': username,
                          'Company Name': company_name,
                          'Designation': designation,
                        })
                        .then((value) => print("User Updated"))
                        .catchError(
                            (error) => print("Failed to update user: $error"));
                  }

                  updateUser();
                },
                child: const Text('Update')),
          ])),
        ),
      ),
    );
  }
}
