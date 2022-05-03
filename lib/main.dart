import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/Search%20Pages/companies.dart';
import 'package:get_placed/SideBar%20Pages/add_review.dart';
import 'package:get_placed/SideBar%20Pages/jobs.dart';
import 'package:get_placed/SideBar%20Pages/manage_profile.dart';
import 'package:get_placed/SideBar%20Pages/saved.dart';
import 'package:get_placed/SideBar%20Pages/study_material.dart';
import 'package:get_placed/SideBar%20Pages/user_home.dart';
import 'package:get_placed/Study%20Materials/add_study_material.dart';
import 'package:get_placed/homepage.dart';
import 'package:get_placed/provider/email_Authentication.dart';
import 'package:get_placed/provider/google_sign_in.dart';
import 'package:get_placed/search_page.dart';
import 'package:provider/provider.dart';

import 'Job/add_jobs.dart';
import 'Search Pages/designation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
          create: (context)=>GoogleSignInProvider(),),

          Provider<AuthenticationService>(create: (_)=>AuthenticationService(FirebaseAuth.instance),),
          StreamProvider(
              create: (context)=> context.read<AuthenticationService>().authStateChanges,
              initialData: null,
          ),
        ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
            initialRoute: '/',
            routes: {
          '/UserHome': (context) => const UserHome(),
          '/Saved': (context) => const SavedContent(),
          '/ManageProfile': (context) => const ManageProfile(),
          '/Add Review': (context) => const AddReview(),
          '/Search Page': (context) => const SearchPage(),
          '/Jobs Page': (context) => JobsPage(),
          '/Study Material Page': (context) => const StudyMaterialPage(),
          '/Add Jobs': (context) => const AddJobsList(),
          '/Add Study Material': (context) => const AddStudyMaterial(),
          '/Search Companies': (context) => const SearchCompanies(),
          '/Search Designations': (context) => const SearchDesignation(),
        },
          ),
      );
}
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
    await Future.delayed(Duration(seconds: 5),() {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
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
