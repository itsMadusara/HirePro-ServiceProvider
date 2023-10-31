import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/Providers/spProvider.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/services/urlCreator.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

List<String> images = [
  'images/male1.jpg',
  'images/male2.jpg',
  'images/male3.jpg'
];

class _UserProfileState extends State<UserProfile> {


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _loadUserData();
      await getImageUrl();
      await addSelectedCategoryImages();
    });
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
  List<String> selectedImages = [];

  Future<String> addSelectedCategoryImages() async {
    selectedImages.clear(); // Clear the existing selected images list
    for (var element in categories) {
      selectedCategories.add(element.toString());
    }
    for (String category in selectedCategories) {
      int index = allCategories.indexOf(category);
      if (index >= 0 && index < allCategoryImagePaths.length) {
        selectedImages.add(allCategoryImagePaths[index]);
      }
    }
    return '1';
  }

  void _handleBoxTap(int index) {
    if (index == selectedImages.length) {
      Navigator.pushNamed(context, '/add_category').then((result) {
        if (result != null && result is String) {
          setState(() {
            selectedImages.add(result);
          });
        }
      });
    }
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

  Future<void> getImageUrl() async {
    try {
      await Firebase.initializeApp();
      final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference ref = storage.ref('serviceProvider/profilePicture/$id.png');
      final String downloadURL = await ref.getDownloadURL();
      setState(() {
        imageURL = downloadURL;
      });
      isLoadingImage = false;
      print(imageURL);
    } catch (e) {
      print('Error retrieving image from Firebase Storage: $e');
    }
  }

  bool isLoading = true; // Set initial loading state to true
  bool isLoadingImage = true;
  String name = '';
  String id = '';
  String email = '';
  String intro = '';
  String imageURL = '';
  List<dynamic> categories = [];

  Future<void> _loadUserData() async {
    try {
      final userData = await fetchSP();
      print(userData);
      Map<String, dynamic> userDataMap = jsonDecode(userData);
      setState(() {
        name = userDataMap['name'];
        id = userDataMap['id'];
        email = userDataMap['email'];
        intro = userDataMap['intro'] ?? '';
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

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: isLoading ? Center(child: CircularProgressIndicator()) :
        Scaffold(
            appBar: AppBarBackAndMore(),
            bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: Center(
              child: SingleChildScrollView(
                child:Container(
                  height: 950,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: kMainYellow,
                              width: 2,
                            ),
                          ),
                          child: Hero(
                            tag: "image",
                            child: ClipOval(
                              child: isLoadingImage ? Center(child: CircularProgressIndicator()) :
                              Image(
                                image: NetworkImage(imageURL),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(name,
                          style: TextStyle(
                            fontSize: 30,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        RatingBarIndicator(
                          rating: 3.35,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          direction: Axis.horizontal,
                        ),
                        Text('HirePro ID - ' + id,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(intro,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),

                        SizedBox(height: 15,),
                        ProfileSummary('1000' , 'Revenue Earned'),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfileWidgets(TextButton(  onPressed: () { },
                              child: Text('15', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800),),), 'Completed'),
                            ProfileWidgets(IconButton.filled(
                              icon: const Icon(Icons.attach_money),
                              onPressed: () {Navigator.pushNamed(context, '/view_wallet');},), 'Wallet'),
                            ProfileWidgets(IconButton(icon: Icon(Icons.help), onPressed: (){},), 'Help')
                          ],
                        ),

                        const Divider(
                          height: 2,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.grey,
                        ),

                        SizedBox(height: 5,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6,),
                              // Text(serviceProvider.serviceProviderData!.intro),
                            ],
                          ),
                        ),
                        SizedBox(height: 12,),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text('Categories',
                                      style: TextStyle(
                                          color: kMainYellow,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 5,),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to another page when the Icon is tapped
                                        Navigator.pushNamed(context, '/edit_categories');
                                      },
                                      child: Icon(Icons.edit),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < 3; i++)
                              GestureDetector(
                                onTap: () {
                                  if (i == selectedImages.length) {
                                    Navigator.pushNamed(context, '/add_category').then((result) {
                                      if (result != null && result is String) {
                                        setState(() {
                                          selectedImages.add(result);
                                        });
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  color: selectedImages.length > i ? Colors.black : Colors.grey[300],
                                  child: selectedImages.length > i
                                      ? Image.asset(
                                    selectedImages[i],
                                    fit: BoxFit.cover,
                                  )
                                      : Icon(Icons.add, size: 50),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 12,),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text('Featured Projects',
                                      style: TextStyle(
                                          color: kMainYellow,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 5,),
                                    Icon(Icons.edit,)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gallery(),
                        MainButton('My Reviews', () {Navigator.pushNamed(context, '/view_reviews');}),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),

            )));
  }
}

class ProfileSummary extends StatelessWidget {
  final String big;
  final String small;
  ProfileSummary(this.big, this.small);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          big,
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        Text(small,
            style: TextStyle(
              fontSize: 10,
            ))
      ],
    );
  }
}

class ProfileWidgets extends StatelessWidget {
  final String text;
  final Widget button;
  ProfileWidgets(this.button, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        children: [
          button,
          Text(text,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 13,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}

class Gallery extends StatelessWidget {
  const Gallery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 200,
      child: Stack(
        children: [
          Swiper(
            // autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              final image = images[index];
              return Image.asset(
                image,
                fit: BoxFit.fill,
              );
            },
            itemCount: images.length,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        // Handle left scrolling
                        // You can call swiper.previous() to scroll left
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        // Handle right scrolling
                        // You can call swiper.next() to scroll right
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}