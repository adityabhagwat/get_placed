import 'package:flutter/material.dart';
import 'package:get_placed/login_page.dart';

class Registration_Form extends StatefulWidget {
  const Registration_Form({Key? key}) : super(key: key);

  @override
  _Registration_FormState createState() => _Registration_FormState();
}

class _Registration_FormState extends State<Registration_Form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('getPlaced'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
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
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                    icon: Icon(Icons.email_rounded),
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                    icon: Icon(Icons.password_rounded),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: ()async{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child: const Text('Register',style: TextStyle(fontSize: 20,),)
                ),
                const SizedBox(height: 20,),
                TextButton(onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                    child: Text(
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
    );
  }
}
