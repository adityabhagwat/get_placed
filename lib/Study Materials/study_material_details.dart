import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudyMaterialDetails extends StatefulWidget {
  const StudyMaterialDetails({required this.data});

  final QueryDocumentSnapshot<Object?> data;

  @override
  State<StudyMaterialDetails> createState() => _StudyMaterialDetailsState();
}

class _StudyMaterialDetailsState extends State<StudyMaterialDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
