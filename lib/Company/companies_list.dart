import 'company_const.dart';
import 'company_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyList extends StatefulWidget {
  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  @override
  Widget build(BuildContext context) {

    final List companies = Provider.of<List<Company>>(context);

    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return CompanyTile(company: companies[index]['Company Name']);
        },
      ),
    );
  }
}