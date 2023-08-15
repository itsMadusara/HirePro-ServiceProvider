

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadImageBox extends StatelessWidget {
  UploadImageBox(this.placeholder);
  final String placeholder;

  void openFiles() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: true);
    List<PlatformFile> files =
    []; // Declare the 'files' list outside the if block

    if (result != null) {
      files = result.paths
          .map((path) => PlatformFile(
        path: path,
        name: 'default_filename', // Provide a default filename
        size: 0, // Provide a default size (e.g., 0 bytes)
      ))
          .toList();
    } else {
      // User canceled the picker
      // Handle the cancelation or provide appropriate code here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 330,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.cloud_upload_outlined,size: 40,),
              color: Colors.grey,
              onPressed: () {
                openFiles();
              },
            ),
            Text(placeholder, style: TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}