import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/ToggleEyeField.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/UploadMultipleImagesBox.dart';

import '../../widgets/MainCard.dart';

class EditCategories extends StatefulWidget {
  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {

  final List<String> allCategories = [
    'Gardening',
    'Plumbing',
    'Cleaning',
    'Furniture Mounting',
    'Hair Cutting',
    'Lawn Mowing',
    'Painting'
  ];

  final List<String> allCategoryImagePaths = [
  'images/cleaning.png',
  'images/hair-cut.png',
  'images/painting.png',
  'images/plumber.png',
  'images/cleaning.png',
  'images/hair-cut.png',
  'images/hair-cut.png',
  ];

  // pass the list of tasks here from backend --> maximum 3 categories
  List<String> selectedCategories = ['Cleaning', 'Painting'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBarTitle(title: 'Edit Categories'),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              for (final category in selectedCategories)
                Container(
                  margin: EdgeInsets.only(bottom: 20), // Add margin for spacing
                  child: CategoryCard(
                    categoryName: category,
                    categoryImagePath: getCategoryImagePath(category),
                    onClose: () {
                      setState(() {
                        selectedCategories.remove(category);
                      });
                    },
                  ),
                ),
              SizedBox(height: 40,),
              if (selectedCategories.length < 3)
                Center(
                  child: MainButton('Add Category', () {
                    Navigator.pushNamed(context, '/add_category');
                  }),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String getCategoryImagePath(String categoryName) {
    final index = allCategories.indexOf(categoryName);
    if (index != -1 && index < allCategoryImagePaths.length) {
      return allCategoryImagePaths[index];
    }
    return '';
  }

}


class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryImagePath;
  final VoidCallback? onClose;

  CategoryCard({
    required this.categoryName,
    required this.categoryImagePath,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return MainCard(
      130,
      325,
      Color(0XFFF5F5F5),
      Stack(
        children: [
          Row(
            children: [
              Image.asset(categoryImagePath),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(categoryImagePath),
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: kMainYellow,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _showRemoveConfirmationDialog(context);
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRemoveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded border for the dialog
          ),
          title: Text('Remove Category?'),
          content: Text('Are you sure you want to remove from categories?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20.0), // Rounded border for the button
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    if (onClose != null) {
                      onClose!(); // Call the onClose callback
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: kMainYellow,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}