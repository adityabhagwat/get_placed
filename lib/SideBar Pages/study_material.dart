import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudyMaterialPage extends StatefulWidget {
  const StudyMaterialPage({Key? key}) : super(key: key);

  @override
  _StudyMaterialPageState createState() => _StudyMaterialPageState();
}

class _StudyMaterialPageState extends State<StudyMaterialPage> {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('study_material');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('getPlaced'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchMaterial(),
                );
              },
              icon: Icon(Icons.search)),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/Add Study Material');
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Study Material'),
          )
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
                    final String? topic = data['Topic'];
                    final String? link = data['link'];

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          "Topic : " + topic!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: TextButton(
                          onPressed: () {
                            launch(link!);
                          },
                          child: const Text(
                            'Go to Content',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
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

class SearchMaterial extends SearchDelegate {
  final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('study_material');

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
                    element['Topic']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No search query found"),
              );
            } else {
              return ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  ...snapshot.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['Topic']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String? topicName = data['Topic'];
                    final String? link = data['link'];

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          "Topic : " + topicName!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: TextButton(
                            onPressed: () {
                              launch(link!);
                            },
                            child: const Text(
                              'Go to Content',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )),
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
    return const Center(child: Text('Search Material by Topics'));
  }
}
