import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/provider/email_Authentication.dart';
import 'package:get_placed/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override

  Widget build(BuildContext context) {


    var collection = FirebaseFirestore.instance.collection('login_details');
    User user = FirebaseAuth.instance.currentUser!;
    String uid = user.uid;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [

          UserAccountsDrawerHeader(
              accountName:  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: collection.doc(uid).snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                  if (snapshot.hasData) {
                    var output = snapshot.data!.data();
                    var value = output!['name']; // <-- Your value
                    return Text('$value');
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
              accountEmail: Text(user.email!),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network(user.photoURL!),
                )
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/sidebar_bg.jpg'),
              fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/UserHome');
            },
          ),
          ListTile(
            leading: Icon(Icons.reviews),
            title: Text('Add Review'),
            onTap: () {
              Navigator.pushNamed(context, '/Add Review');
            },
          ),
          ListTile(
            leading: Icon(Icons.badge),
            title: Text('Designations'),
            onTap: () {
              Navigator.pushNamed(context, '/Search Designations');
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Jobs'),
            onTap: () {
              Navigator.pushNamed(context, '/Jobs Page');
            },
          ),
          ListTile(
            leading: Icon(Icons.menu_book_outlined),
            title: Text('Study Material'),
            onTap: () {
              Navigator.pushNamed(context, '/Study Material Page');
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Manage Account'),
            onTap: () {
              Navigator.pushNamed(context, '/ManageProfile');
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_open_outlined),
            title: Text('Log Out'),
            onTap: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              context.read<AuthenticationService>().signOut();
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share App'),
            onTap: () {},
          ),

        ],

      ),
    );
  }
}
