import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/Job/job_details.dart';

class JobsPage extends StatelessWidget {
  final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('joblist');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('getPlaced'),
        actions: <Widget>[
          IconButton(onPressed: (){
            showSearch(
              context: context,
              delegate: Jobs(),
            );
          },
              icon: Icon(Icons.search)),
          ElevatedButton.icon(
            onPressed: (){
              Navigator.pushNamed(context, '/Add Jobs');
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Jobs'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.orderBy('date',descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              return ListView(
                children: [
                  ...snapshot.data!.docs.map((QueryDocumentSnapshot<Object?> data) {
                    final String companyName = data['Company Name'];
                    final String designation = data['Designation'] ;
                    final String link = data['job_link'];

                    return Card(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>JobDetailsPage(data:data)));
                        },
                        leading: Text(companyName),
                        title: Text(designation),
                        subtitle: Text(link),
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





class Jobs extends SearchDelegate{
  
  final CollectionReference _firebaseFirestore = FirebaseFirestore.instance.collection('joblist');
  
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
      icon: Icon(Icons.close),
      onPressed: (){
        query = "";
      },
    ),
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: (){
            Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back)
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else{

            if(snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Company Name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())).isEmpty){
              return Center(child: Text("No search query found"),);
            }
            else{
              return ListView(
                children: [
                  ...snapshot.data!.docs.where((QueryDocumentSnapshot<Object?> element) => element['Company Name']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?> data) {
                    final String companyName = data['Company Name'];
                    final String designation = data['Designation'] ;
                    final String link = data['job_link'];

                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>JobDetailsPage(data:data)));
                      },
                      leading: Text(companyName),
                      title: Text(designation),
                      subtitle: Text(link),
                    );
                  })
                ],
              );
            }
          }

        }
    );


    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const Center(child: Text('Search Jobs by Company Name'));
    throw UnimplementedError();
  }
  
}