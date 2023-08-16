import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadMultipleImagesBox extends StatefulWidget {
  UploadMultipleImagesBox(this.placeholder);
  final String placeholder;

  @override
  _UploadMultipleImagesBoxState createState() => _UploadMultipleImagesBoxState();
}

class _UploadMultipleImagesBoxState extends State<UploadMultipleImagesBox> {
  List<File> selectedFiles = [];

  void openFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        selectedFiles.addAll(files);
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
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                for (File file in selectedFiles)
                  Container(
                    width: 150,
                    height: 150,
                    child: Image.file(file, fit: BoxFit.cover),
                  ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add, size: 40),
                        onPressed: openFiles,
                      ),
                      Text(widget.placeholder, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}