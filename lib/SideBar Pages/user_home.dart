import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/side_nav.dart';


class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  final Stream<QuerySnapshot> _reviews = FirebaseFirestore.instance.collection('Reviews').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('getPlaced'),
      ),
      body:SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5,),
               Container(
                 margin: EdgeInsets.all(10.0),
                 child: TextField(
                  onTap: () {
                    Navigator.pushNamed(context, '/Search Page');
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search Companies/Designation",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
              ),
               ),
              SizedBox(height: 5,),
              Container(
                height: 500,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _reviews,
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
                                elevation: 5,
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
                                  title:
                                  RichText(
                                      text: TextSpan(
                                          children: [
                                            const TextSpan(text: "Company Name : ", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black,)
                                            ),
                                            TextSpan(text: '${data.docs[index]['Company Name']}', style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.red,
                                              fontSize: 20,
                                            ),
                                            ),
                                            const TextSpan(text: "\n"),
                                            const TextSpan(text: "Designation : ", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black,)
                                            ),
                                            TextSpan(text: '${data.docs[index]['Designation']}', style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.blue,
                                              fontSize: 18,
                                            ),
                                            ),
                                            const TextSpan(text: "\n"),
                                            const TextSpan(text: "Number of Rounds : ", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black,)
                                            ),
                                            TextSpan(text: '${data.docs[index]['No of Rounds']}', style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                            ),
                                            const TextSpan(text: "\n"),
                                            const TextSpan(text: "Procedure : ", style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black,)
                                            ),
                                            TextSpan(text: '${data.docs[index]['Procedure']}', style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                            ),
                                            const TextSpan(text: "\n"),
                                            const TextSpan(
                                    text: "Topic to Prepare: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    )),
                                            TextSpan(text: '${data.docs[index]['Questions']}', style: const TextStyle(
                                              color: Colors.black,
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
              ),
            ]
          ),
      ),
    );
  }
}
