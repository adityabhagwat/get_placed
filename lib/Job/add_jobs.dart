import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddJobsList extends StatefulWidget {
  const AddJobsList({Key? key}) : super(key: key);

  @override
  _AddJobsListState createState() => _AddJobsListState();
}

class _AddJobsListState extends State<AddJobsList> {

  String? companyName,designation,link,description;
  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('getPlaced'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Company Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value){
                  companyName = value;
                },
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Designation',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value){
                  designation = value;
                },
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Job Link',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value){
                  link = value;
                },
              ),
              SizedBox(height: 20,),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Enter Job Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                onChanged: (value){
                  description = value;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () async{
                    CollectionReference jobs = FirebaseFirestore.instance.collection('joblist');
                    Future<void> addJob() {
                      // Call the user's CollectionReference to add a new user
                      return jobs
                          .add({
                            "Company Name": companyName,
                            "Designation": designation,
                            "description": description,
                            "job_link": link,
                            "date": date.toString(),
                          })
                          .then((value) => print("Job Added"))
                          .catchError((error) => print("Failed to add Review: $error"));
                    }

                    await showDialog<String>(context: context, builder: (BuildContext context)=> AlertDialog(
                      title: const Text('getPlaced',style: TextStyle(
                        color: Colors.lightBlue,
                      ),),
                      content: const Text('Thank You!', style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      actions: <Widget>[
                        TextButton(onPressed: (){return Navigator.pop(context,'OK');}, child: const Text('OK')),
                      ],

                    )
                    );
                    addJob();
                    Navigator.pop(context);
                  },
                  child: Text('Add Job', style: TextStyle(fontSize: 20),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
