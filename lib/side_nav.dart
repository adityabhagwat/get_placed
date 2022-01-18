import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          UserAccountsDrawerHeader(
              accountName:  Text(user.displayName!),
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
            leading: Icon(Icons.bookmark),
            title: Text('Saved'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Manage Account'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lock_open_outlined),
            title: Text('Log Out'),
            onTap: () {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
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
