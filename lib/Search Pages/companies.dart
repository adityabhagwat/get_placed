import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:get_placed/Company/company_const.dart';

class SearchCompanies extends StatelessWidget {
  const SearchCompanies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> companies = FirebaseFirestore.instance.collection('Companies').snapshots();
    return FirestoreSearchScaffold(
      firestoreCollectionName: 'Companies',
      searchBy: 'Company Name',
      scaffoldBody: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: companies,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Text('Loding......');
            }
            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index){
                  return Card(
                    elevation: 10,
                    borderOnForeground: true,
                    child: ListTile(
                      onTap: (){
                        showDialog<String>(context: context, builder: (BuildContext context)=> AlertDialog(
                          title: const Text('getPlaced',style: TextStyle(
                            color: Colors.lightBlue,
                          ),),
                          content: Text('${data.docs[index]['Company Name']}', style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),),
                          actions: <Widget>[
                            TextButton(onPressed: (){return Navigator.pop(context,'OK');}, child: const Text('OK')),
                          ],

                        )
                        );

                      },
                      textColor: Colors.lightBlue,
                      dense: true,
                      title:  Text('${data.docs[index]['Company Name']}',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  );
                }
            );
          },
        ),

      ),
      dataListFromSnapshot: Company().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Company>? dataList = snapshot.data;
          if (dataList!.isEmpty) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final Company data = dataList[index];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${data.companyName}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                );
              });
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
