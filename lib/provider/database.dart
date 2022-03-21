import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/Company/company_const.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference companyCollection = FirebaseFirestore.instance.collection('Companies');



}
