import 'package:cloud_firestore/cloud_firestore.dart';

class Company{

  String? companyName;
  Company({this.companyName});

  List<Company> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return Company(
          companyName: dataMap['Company Name']);
    }).toList();
  }

}