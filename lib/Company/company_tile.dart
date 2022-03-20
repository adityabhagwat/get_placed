import 'company_const.dart';
import 'package:flutter/material.dart';

class CompanyTile extends StatelessWidget {

  final Company company;
  CompanyTile({ required this.company });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(company.companyName!),
        ),
      ),
    );
  }
}