import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/side_nav.dart';

class SearchCompanies extends StatefulWidget {
  const SearchCompanies({Key? key}) : super(key: key);

  @override
  _SearchCompanies createState() => _SearchCompanies();
}

class _SearchCompanies extends State<SearchCompanies> {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('Companies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Companies'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchCompany(),
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

class SearchCompany extends SearchDelegate {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('Companies');

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
                    element['Company Name']
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
                          element['Company Name']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String? companyName = data['Company Name'];

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
    return const Center(child: Text('Search by Company Name'));
  }
}
