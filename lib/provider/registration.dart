import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference login_details_collecttion = FirebaseFirestore.instance.collection('login_details');

  Future<void> updateUserData(String name) async {
    return await login_details_collecttion.doc(uid).set({
      'name': name,
      'Company Name':null,
      'Designation':null,
    });
  }

}