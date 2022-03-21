import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/Company/companies_list.dart';
import 'package:get_placed/Company/company_const.dart';
import 'package:get_placed/Designations/designation_const.dart';
import 'package:get_placed/Designations/designations_list.dart';
import 'package:get_placed/provider/database.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
  with TickerProviderStateMixin{
    late TabController _tabController;

    final Stream<QuerySnapshot> companies = FirebaseFirestore.instance.collection('Companies').snapshots();
    final Stream<QuerySnapshot> designations = FirebaseFirestore.instance.collection('Designations').snapshots();


    @override
    void initState(){
      super.initState();
      _tabController = TabController(length: 2, vsync: this);
      int _selectedIndex;
      _tabController.addListener(() {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      Widget? searchBar;
      String? search_companies;
      String? search_designations;
      return Scaffold(
          appBar: AppBar(
            title: Text('getPlaced'),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  text: 'Companies',
                  icon: Icon(Icons.business,color:Colors.black,),
                ),
                Tab(
                  text: 'Designations',
                  icon: Icon(Icons.business_center_outlined,color: Colors.black,),
                ),
              ],
            ),
          ),
        body: TabBarView(
            controller: _tabController,
            children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value){
                          search_companies = value;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search Companies',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                            )
                          )
                        ),
                        onTap: (){Navigator.pushNamed(context, '/Company Page');},
                      ),
                      Container(
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

                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value){
                          search_designations = value;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search Designations',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                )
                            )
                        ),
                      ),
                      Container(
                        height: 450,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: designations,
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
                                  return Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: SingleChildScrollView(
                                      child: Card(
                                        elevation: 10,
                                        borderOnForeground: true,
                                        child: ListTile(
                                          onTap: (){
                                            showDialog<String>(context: context, builder: (BuildContext context)=> AlertDialog(
                                              title: const Text('getPlaced',style: TextStyle(
                                                color: Colors.lightBlue,
                                              ),),
                                              content: Text('${data.docs[index]['Designation']}', style: TextStyle(
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
                                          title:
                                          RichText(
                                              text: TextSpan(
                                                  children: [
                                                    const TextSpan(text: "Designation : ", style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.black,)
                                                    ),
                                                    TextSpan(text: '${data.docs[index]['Designation']}', style: const TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.blue,
                                                      fontSize: 20,
                                                    ),
                                                    ),
                                                    const TextSpan(text: "\n"),
                                                    const TextSpan(text: "Company Name : ", style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.black,)
                                                    ),
                                                    TextSpan(text: '${data.docs[index]['Company Name']}', style: const TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.red,
                                                      fontSize: 18,
                                                    ),
                                                    ),
                                                    const TextSpan(text: "\n"),
                                                    const TextSpan(text: "Salary : ", style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.black,)
                                                    ),
                                                    TextSpan(text: '${data.docs[index]['Salary Package']}', style: const TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.green,
                                                      fontSize: 16,
                                                    ),
                                                    ),
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            );
                          },
                        ),

                      )
                    ],
                  ),
                ),
            ],
        ),

      );
    }





}


