import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/side_nav.dart';

class SearchDesignation extends StatefulWidget {
  const SearchDesignation({Key? key}) : super(key: key);

  @override
  _SearchDesignation createState() => _SearchDesignation();
}

class _SearchDesignation extends State<SearchDesignation> {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('Designations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Designations'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchDesgs(),
                );
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String? companyName = data['Company Name'];
                    final String? designation = data['Designation'];
                    final String? salaryPackage =
                        data['Salary Package'].toString();

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Company Name : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              )),
                          TextSpan(
                            text: '$companyName',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                          const TextSpan(text: "\n"),
                          const TextSpan(
                              text: "Designation : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              )),
                          TextSpan(
                            text: '$designation',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                          const TextSpan(text: "\n"),
                          const TextSpan(
                              text: "Salary : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              )),
                          TextSpan(
                            text: '$salaryPackage',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                      ),
                    );
                  })
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class SearchDesgs extends SearchDelegate {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('Designations');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['Designation']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No search query found"),
              );
            } else {
              return ListView(
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['Designation']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String? companyName = data['Company Name'];
                    final String? designation = data['Designation'];
                    final String? salaryPackage =
                        data['Salary Package'].toString();

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Company Name : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              )),
                          TextSpan(
                            text: '$companyName',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                          const TextSpan(text: "\n"),
                          const TextSpan(
                              text: "Designation : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              )),
                          TextSpan(
                            text: '$designation',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                          const TextSpan(text: "\n"),
                          const TextSpan(
                              text: "Salary : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              )),
                          TextSpan(
                            text: '$salaryPackage',
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ])),
                      ),
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Search by Designation Name'));
  }
}
