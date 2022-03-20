import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/side_nav.dart';

class AddReview extends StatefulWidget {
  const AddReview({Key? key}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  String? companyName,designation,procedure,questions;
  double? salary;
  int? noRounds;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('getPlaced'),
      ),
      drawer: NavBar(),
      body:SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
          child: Form(
            child: Column(
              children:[
                Text(
                  'Add Review',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                    companyName = value;
                  },
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                    designation = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Designation Applied For',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                    salary = double.parse(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Salary Package Offered',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                    noRounds = int.parse(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'No. of Selection Rounds',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                    procedure = value;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Describe Procedure',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  onChanged: (value){
                    questions = value;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Questions Asked/ Topics for Questions',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async{
                      CollectionReference reviews = FirebaseFirestore.instance.collection('Reviews');
                      Future<void> addReview() {
                        // Call the user's CollectionReference to add a new user
                        return reviews
                            .add({
                          "Company Name": companyName,
                          "Designation": designation,
                          "No of Rounds":noRounds,
                          "Procedure":procedure,
                          "Questions":questions,
                          "Salary Package":salary
                        })
                            .then((value) => print("Review Added"))
                            .catchError((error) => print("Failed to add Review: $error"));
                      }


                      addReview();

                      CollectionReference companies = FirebaseFirestore.instance.collection('Companies');


                      Future<void> addCompany() {
                        // Call the user's CollectionReference to add a new user
                        return companies
                            .add({
                          "Company Name": companyName,
                        })
                            .then((value) => print("Company Added"))
                            .catchError((error) => print("Failed to add Company: $error"));
                      }






                      CollectionReference designations = FirebaseFirestore.instance.collection('Designations');
                      Future<void> addDesignation() {
                        // Call the user's CollectionReference to add a new user
                        return designations
                            .add({
                          "Company Name": companyName,
                          "Designation": designation,
                          "Salary Package":salary
                        })
                            .then((value) => print("Designation Added"))
                            .catchError((error) => print("Failed to add Designation: $error"));
                      }
                      addDesignation();


                      await showDialog<String>(context: context, builder: (BuildContext context)=> AlertDialog(
                      title: const Text('getPlaced',style: TextStyle(
                      color: Colors.lightBlue,
                      ),),
                      content: const Text('Thank You For Your Review', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      ),),
                      actions: <Widget>[
                      TextButton(onPressed: (){return Navigator.pop(context,'OK');}, child: const Text('OK')),
                      ],

                      )
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddReview()));
                    },
                    child:Text('Submit',style: TextStyle(fontSize: 20,),),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
