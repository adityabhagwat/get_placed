
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      appBar: AppBar(
        title: const Text('getPlaced'),
        elevation: 10,
        backgroundColor: Colors.lightBlueAccent,
        leading: Image.asset('lib/images/gPapplogo.jpg'),
        ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
            'WELCOME',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
            ),
          ),
          const SizedBox(height: 30,),
          Container(
            decoration: const BoxDecoration(
              boxShadow:[
                BoxShadow(
                  color: Colors.lightBlueAccent,
                  blurRadius: 200,
                )
              ]
            ),
            child: TextFormField(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide.none,
                ),
                icon: Icon(Icons.email_outlined,
                color: Colors.blue,),
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
              decoration: const BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      color: Colors.lightBlueAccent,
                      blurRadius: 200,
                    )
                  ]
              ),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide.none,
                  ),
                  icon: Icon(Icons.vpn_key_outlined,
                    color: Colors.blue,),
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
                    color: Colors.blue,
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
                  elevation: 20,
                  shadowColor: Colors.lightBlueAccent,
                  onPrimary: Colors.black87,
                  primary: Colors.white,
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),

                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
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
            const SizedBox(height: 20,),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'New User ? Click Here to Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
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
