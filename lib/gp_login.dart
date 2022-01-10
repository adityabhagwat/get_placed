
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_placed/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'provider/google_sign_in.dart';
class gp_login extends StatefulWidget {

  @override
  _gp_loginState createState() => _gp_loginState();
}

class _gp_loginState extends State<gp_login> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlueAccent,
                  Colors.lightBlue,
                  Colors.blue,
                  Colors.blueAccent,
                ],
                stops: [0.1,0.3,0.7,0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 120.0,
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text(
            'Sign In',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30,),
          Container(
            decoration: BoxDecoration(
              boxShadow:[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 100,
                )
              ]
            ),
            child: const TextField(
              decoration: InputDecoration(
                fillColor: Colors.lightBlueAccent,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide.none,
                ),
                icon: Icon(Icons.email_outlined,
                color: Colors.white,),
                hintText: 'Email',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.greenAccent,width: 3)),
                contentPadding: EdgeInsets.only(top:10.0,bottom: 10.0, left: 10.0, right: 10.0),
              ),
            ),
          ),
            const SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 100,
                    )
                  ]
              ),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none,
                  ),
                  icon: Icon(Icons.vpn_key_outlined,
                    color: Colors.white,),
                  hintText: 'Password',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.greenAccent,width: 3)),
                  contentPadding: EdgeInsets.only(top:10.0,bottom: 10.0, left: 10.0, right: 10.0),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            TextButton(
                onPressed:() {},
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            const SizedBox(height: 30,),
            SizedBox(
              height: 50,
              width: 140,
              child:ElevatedButton(
                onPressed:() {},
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black87,
                  primary: Colors.lightGreenAccent,
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),

                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

              ),
            ),
            const SizedBox(height: 30,),
            const Text(
              '-- OR --',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30,),
            const Text(
              'Sign In With',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30,),
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
                         color: Colors.white,
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
                        color: Colors.white,
                      ),

                    )
                  ],
                ),
              ],
            ),
]
      ),
    ),
          )
        ],
      ),
    );
  }


}
