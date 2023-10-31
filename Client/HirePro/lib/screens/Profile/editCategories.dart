import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/ToggleEyeField.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/UploadMultipleImagesBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../services/urlCreator.dart';
import '../../widgets/MainCard.dart';

class EditCategories extends StatefulWidget {
  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _loadUserData();
      await addSelectedCategoryImages();
    });
  }

  Future<String> addSelectedCategoryImages() async {
    for (var element in categories) {
      selectedCategories.add(element.toString());
    }
    return '1';
  }

  String getCategoryImagePath(String categoryName) {
    final index = allCategories.indexOf(categoryName);
    if (index != -1 && index < allCategoryImagePaths.length) {
      return allCategoryImagePaths[index];
    }
    return '';
  }

  Future<String> fetchSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse(urlCreate('getUser')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']});
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        fetchSP();
      }
      throw Exception('Failed to load album');
    }
  }

  bool isLoading = true; // Set initial loading state to true
  List<dynamic> categories = [];

  Future<void> _loadUserData() async {
    try {
      final userData = await fetchSP();
      print(userData);
      Map<String, dynamic> userDataMap = jsonDecode(userData);
      setState(() {
        categories = userDataMap['category'];
      });
      isLoading = false;
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        isLoading = false; // Set isLoading to false even in case of error
      });
    }
  }

  final List<String> allCategories = [
    'Gardening',
    'Plumbing',
    'House Cleaning',
    'Furniture Mounting',
    'Hair Dressing',
    'Lawn Moving',
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
  List<String> selectedCategories = [];

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

}


class CategoryCard extends StatelessWidget {
  Future<String> deleteCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(urlCreate('deleteCategory')),
        headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['accessToken']},
        body: jsonEncode({'category': categoryName})
    );
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      if(jsonDecode(response.body)['error'] == 'TokenExpiredError'){
        response = await http.get(Uri.parse(urlCreate('refreshToken')),
            headers: {'Content-Type': 'application/json' , 'authorization' : jsonDecode(prefs.getString('tokens') ?? '')['refreshToken']});
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['tokens']);
        await prefs.setString('tokens', jsonEncode(jsonResponse['tokens']));
        deleteCategory();
      }
      throw Exception('Failed to load album');
    }
  }

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
                      deleteCategory();
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