import 'package:flutter/material.dart';
import 'package:get_placed/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_placed/provider/email_Authentication.dart';
import 'package:provider/src/provider.dart';

class Registration_Form extends StatefulWidget {
  const Registration_Form({Key? key}) : super(key: key);

  @override
  _Registration_FormState createState() => _Registration_FormState();
}

class _Registration_FormState extends State<Registration_Form> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController eMail =  TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('getPlaced'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
              },
            icon:const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
            child: Form(
              child: Column(
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an First Name' : null,
                    controller: fName,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an Last Name' : null,
                    controller: lName,
                    decoration: const InputDecoration(
                        labelText: 'Last Name',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                    controller: eMail,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                      icon: Icon(Icons.email_rounded),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                      icon: Icon(Icons.password_rounded),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: ()async{

                        if(_formKey.currentState!.validate()){
                          setState(() => loading = true);

                          dynamic result = await context.read<AuthenticationService>().signUp(
                            eMail.text,
                            password.text,
                            fName.text+" "+lName.text,
                          );


                          if(result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          }
                          else{
                            await showDialog<String>(context: context, builder: (BuildContext context)=> AlertDialog(
                              title: const Text('getPlaced',style: TextStyle(
                                color: Colors.lightBlue,
                              ),),
                              content: const Text('You Are Registered to Get Placed \nHappy Journey with Us !', style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              actions: <Widget>[
                                TextButton(onPressed: (){return Navigator.pop(context,'OK');}, child: const Text('OK')),
                              ],

                            )
                            );

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          }
                        }

                      },
                      child: const Text('Register',style: TextStyle(fontSize: 20,),)
                  ),
                  const SizedBox(height: 20,),
                  TextButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                      child: const Text(
                        'Already User? Sign In Here',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                        ),
                      )
                  ),
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
