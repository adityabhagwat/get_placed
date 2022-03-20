import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({required this.data});

  final QueryDocumentSnapshot<Object?> data;

  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  DateTime? date;
  var d12;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('getPlaced'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Card(
              margin: EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Company Name :  "+widget.data['Company Name']),
                  const SizedBox(height: 10,),
                  Text("Designation  :  "+widget.data['Designation']),
                  const SizedBox(height: 10,),
                  Text("Added on Date:  "+widget.data['date']),
                  const SizedBox(height: 10,),
                  Text("Description  :  "+widget.data['description']),
                  const SizedBox(height: 10,),
                  TextButton(
                      onPressed: (){
                        launch(widget.data['job_link']);
                      },
                      child:const  Text('Apply Here')
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
