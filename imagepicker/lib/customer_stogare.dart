import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class customer extends StatefulWidget {
  const customer({super.key});

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {
  final _imagePicker = ImagePicker();
  File? imagefile;
  getimage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagefile = File(pickedFile.path);
      setState(() {});
      print("image picked");
    }
  }

  final storageRef = FirebaseStorage.instance.ref();

  uplaodfile() {
    UploadTask _uploadTask =
        storageRef.child("images/1.jpg").putFile(imagefile!);

    print("file uploaded");
  }

  deletefile() async {
    await storageRef.child("images/1.jpg").delete();
    print("deleted files");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("firebase storage"),
        backgroundColor: Colors.tealAccent,
      ),
      body: Column(
        children: [
          imagefile != null
              ? Image.file(imagefile!)
              : ElevatedButton(
                  onPressed: () {
                    getimage();
                  },
                  child: Text("pick image")),
          ElevatedButton(
              onPressed: () {
                uplaodfile();
              },
              child: Text("pickimage")),
          ElevatedButton(
            onPressed: () {
              deletefile();
            },
            child: Text("deleted files"),
          )
        ],
      ),
    );
  }
}
