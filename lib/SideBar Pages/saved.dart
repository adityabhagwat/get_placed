import 'package:flutter/material.dart';
import 'package:get_placed/side_nav.dart';

class SavedContent extends StatefulWidget {
  const SavedContent({Key? key}) : super(key: key);

  @override
  _SavedContentState createState() => _SavedContentState();
}

class _SavedContentState extends State<SavedContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title:const Text('getPlaced'),
      ),
      body:Container(
        child: Center(
          child:Text('Saved'),
        ),
      ),
    );
  }
}
