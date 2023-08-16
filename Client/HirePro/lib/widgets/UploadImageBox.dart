import 'dart:io'; // Import the 'dart:io' library for File class
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadImageBox extends StatefulWidget {
  UploadImageBox(this.placeholder);
  final String placeholder;

  @override
  _UploadImageBoxState createState() => _UploadImageBoxState();
}

class _UploadImageBoxState extends State<UploadImageBox> {
  List<File> selectedFiles = []; // Store the selected files

  void openFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        selectedFiles = files; // Update the selected files list
      });
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
        height: 300,
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
            if (selectedFiles.isEmpty)
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.cloud_upload_outlined, size: 40),
                    color: Colors.grey,
                    onPressed: () {
                      openFiles();
                    },
                  ),
                  Text(widget.placeholder, style: TextStyle(color: Colors.grey)),
                ],
              ),
            SizedBox(height: 10), // Add some spacing
            if (selectedFiles.isNotEmpty) // Display selected images
              Column(
                children: selectedFiles.map((file) => Container(
                  width: 300, // Set your desired width
                  height: 250, // Set your desired height
                  child: Image.file(file, fit: BoxFit.cover), // Adjust fit as needed
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }
}