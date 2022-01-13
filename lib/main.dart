import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_placed/login_page.dart';
import 'package:get_placed/provider/google_sign_in.dart';
import 'package:get_placed/registration_form.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _naviagtetologin();
  }

  _naviagtetologin() async{
    await Future.delayed(Duration(seconds: 10),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children:<Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.blueAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black87,
                        radius: 100.0,
                        child: Image.asset(
                          'lib/images/gPapplogo.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(top:10.0)
                      ),
                      const Text(
                        'getPlaced',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    LinearProgressIndicator(
                      color: Colors.red,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text(
                      'Helping Everyone \n    To Get Placed',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
