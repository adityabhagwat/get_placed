import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_placed/provider/firebase_api.dart';
import 'package:path/path.dart';

class AddStudyMaterial extends StatefulWidget {
  const AddStudyMaterial({Key? key}) : super(key: key);

  @override
  _AddStudyMaterialState createState() => _AddStudyMaterialState();
}

class _AddStudyMaterialState extends State<AddStudyMaterial> {
  String? topicName;
  String? materialLink;
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: const Text('getPlaced'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Topic Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      topicName = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Paste Study Material Link',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      materialLink = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        CollectionReference materials = FirebaseFirestore
                            .instance
                            .collection('study_material');
                        Future<void> addStudyMaterial() {
                          // Call the user's CollectionReference to add a new user
                          return materials
                              .add({
                                "Topic": topicName,
                                "link": materialLink,
                              })
                              .then((value) => print("Material Added"))
                              .catchError((error) =>
                                  print("Failed to add Review: $error"));
                        }

                        await showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    'getPlaced',
                                    style: TextStyle(
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                  content: const Text(
                                    'Thank You!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          return Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK')),
                                  ],
                                ));
                        addStudyMaterial();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Add Material',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              )),
              const SizedBox(
                height: 30,
              ),
              const Text(
                '------------- OR -------------',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter Topic Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      topicName = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform
                          .pickFiles(allowMultiple: false);
                      if (result == null) return;
                      final path = result.files.single.path!;

                      setState(() => file = File(path));
                    },
                    icon: Icon(Icons.attach_file),
                    label: Text(
                      'Select File',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    fileName,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (file == null) return;

                      final fileName = basename(file!.path);
                      final destination = 'files/$fileName';

                      task = FirebaseApi.uploadFile(destination, file!);
                      setState(() {});

                      if (task == null) return;
                      final snapshot = await task!.whenComplete(() {});

                      final urlDownload = await snapshot.ref.getDownloadURL();

                      CollectionReference materials = FirebaseFirestore.instance
                          .collection('study_material');
                      Future<void> addStudyMaterial() {
                        // Call the user's CollectionReference to add a new user
                        return materials
                            .add({
                              "Topic": topicName,
                              "link": urlDownload,
                            })
                            .then((value) => print("Material Added"))
                            .catchError((error) =>
                                print("Failed to add Review: $error"));
                      }

                      await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'getPlaced',
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                  ),
                                ),
                                content: const Text(
                                  'Thank You!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        return Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK')),
                                ],
                              ));
                      addStudyMaterial();
                    },
                    icon: Icon(Icons.cloud_upload_outlined),
                    label: Text(
                      'Upload File',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  task != null ? buildUploadStatus(task!) : Container(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  buildUploadStatus(UploadTask task) {
    return StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);

          return Text(
            '$percentage %',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
