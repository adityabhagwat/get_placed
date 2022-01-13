
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/registration_form.dart';
import 'package:provider/provider.dart';

import 'provider/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(top: 5,bottom: 5),
                child: const Text(
                  'WELCOME',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),//title of page
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(top: 5,bottom: 5),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ), //emailfield
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          labelText: 'Password',
                          icon:Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ), //passwordfield
                  ],
                ),
              ), //textfields
              TextButton(
                  onPressed:() {},
                  child: Text(
                    'Forgot Password ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
                    ),
                  )
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shadowColor: Colors.lightBlueAccent,
                    primary: Colors.lightGreenAccent,
                    fixedSize: Size(150, 50),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
              ),
              SizedBox(height: 10,),
              TextButton(
                  onPressed:() {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Registration_Form()));
                  },
                  child: Text(
                    'New User? Click Here to Register',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  )
              ),
              SizedBox(height: 10,),//signinbutton
              Text(
                '-- OR --',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),//Registerbutton
              Text(
                'Sign Up With',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),SizedBox(height: 10,),
              Container(), //or
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    shadowColor: Colors.white,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Image.asset('lib/images/google_logo.png',height: 40,width: 40,),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),

                )
              ],
            ),

            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    shadowColor: Colors.white,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Image.asset('lib/images/fb_logo.png',height: 40,width: 40,),
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Facebook',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),

                )
              ],
            ),
          ],
        ), //signinwithgoogle
            ],
          ),
        ),
      ),
    );
  }
}
