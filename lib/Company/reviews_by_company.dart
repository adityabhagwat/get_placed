import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewsByCompany extends StatelessWidget {
  final String companyName;

  ReviewsByCompany({required this.companyName});

  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('Reviews');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('getPlaced'),
      ),
      /*body: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.where('Company Name',isEqualTo:companyName.toLowerCase()).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return ListView(
                children: [
                  ...snapshot.data!.docs.map((QueryDocumentSnapshot<Object?> data) {
                    final String designation = data['Designation'] ;
                    final String noOfRounds = data['No of Rounds'].toString();
                    final String procedure = data['Procedure'];
                    final String questions = data['Questions'];
                    final String salaryPackage = data['Salary Package'].toString();

                    return Card(
                      elevation: 5,
                      child: ListTile(

                        textColor: Colors.lightBlue,
                        dense: true,
                        title:
                        RichText(
                            text: TextSpan(
                                children: [
                                  const TextSpan(text: "\n"),
                                  const TextSpan(text: "Designation : ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,)
                                  ),
                                  TextSpan(text: designation, style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                  ),
                                  const TextSpan(text: "\n"),
                                  const TextSpan(text: "Number of Rounds : ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,)
                                  ),
                                  TextSpan(text: noOfRounds, style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  ),
                                  const TextSpan(text: "\n"),
                                  const TextSpan(text: "Procedure : ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,)
                                  ),
                                  TextSpan(text: procedure, style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  ),
                                  const TextSpan(text: "\n"),
                                  const TextSpan(text: "Topic to Prepare: ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,)
                                  ),
                                  TextSpan(text: questions, style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  ),
                                  const TextSpan(text: "\n"),
                                  const TextSpan(text: "Salary : ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,)
                                  ),
                                  TextSpan(text: salaryPackage, style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                  ),
                                ]
                            )
                        ),
                      ),
                    );
                  })
                ],
              );
            }
          },
        ),
      ),*/
    );
  }
}
