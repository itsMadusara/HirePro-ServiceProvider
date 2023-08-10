import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/LineDivider.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width:
                            150, // Set the desired width of the container
                            height:
                            150, // Set the desired height of the container
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Create a circular shape
                              border: Border.all(
                                color: kMainYellow, // Set the border color
                                width: 2, // Set the border width
                              ),
                            ),
                            child: Hero(
                              tag: "image",
                              child: ClipOval(
                                child: Image.asset(
                                  'images/profile_pic.png', // Replace with your image URL
                                  fit: BoxFit
                                      .cover, // Adjust the image's fit within the circular border
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Harini Samaliarachchi",
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
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            height: 60,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20), // Add left padding
                                  child: Icon(Icons.location_on, size: 30),
                                ),
                                Expanded( // Make the Row take up all available space
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Address',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '1234 Main Street, City,', // Replace with actual address
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20), // Add right padding
                                ),
                              ],
                            ),
                          ),

                          ProfileSummary('15', 'Total no of jobs'),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: SmallArrowButton(
                                    kSecondaryYellow, Icons.arrow_back, () {})
                            ),
                          ],
                        )
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
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
              fontSize: 70,
              fontWeight: FontWeight.w500,
              color: Color(0xFF625C5C)),
        ),
        Text(small,
            style: TextStyle(
              fontSize: 15,
            ))
      ],
    );
  }
}
