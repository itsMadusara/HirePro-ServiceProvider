import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/UploadMultipleImagesBox.dart';

const List<String> list = <String>['Gardening', 'Plumbing', 'Cleaning', 'Furniture Mounting','Hair Cutting','Lawn Mowing', 'Painting'];

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String selectedCategory = 'Gardening'; // Store the selected category here

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBarTitle(title: 'Add Category'),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),
              Text('Select Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              SizedBox(height: 10,),
              CategoryDropdown(
                value: selectedCategory,
                onChanged: (String value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 25,),
              Text('Upload Proof of work here', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              SizedBox(height: 10,),
              UploadMultipleImagesBox('upload'),
              SizedBox(height: 40,),
              Center(
                child: MainButton('Submit', () {
                  Navigator.of(context).pop();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryDropdown extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  CategoryDropdown({required this.value, required this.onChanged});

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButtonHideUnderline( // Use DropdownButtonHideUnderline
          child: DropdownButton<String>(
            value: widget.value,
            onChanged: (String? value) {
              if (value != null) {
                widget.onChanged(value);
              }
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            icon: Icon(Icons.arrow_drop_down),
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

