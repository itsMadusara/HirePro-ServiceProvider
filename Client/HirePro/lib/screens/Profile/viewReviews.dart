import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/ReviewCard.dart';
import 'package:hire_pro/screens/Profile/reviews.dart';

class ViewReviews extends StatefulWidget {
  @override
  State<ViewReviews> createState() => _ViewReviewsState();
}

class _ViewReviewsState extends State<ViewReviews> {

  final List<Review> reviews = [
    Review(
      profilePicUrl: 'images/male1.jpg',
      name: 'John Doe',
      date: DateTime(2023, 7, 15),
      rating: 4.5,
      content:
      "Wow! I just had the most amazing experience with my hairstylist from the handyman app! They have truly worked magic with my hair. I couldn't be happier with the result!🌟🌟🌟🌟🌟",
    ),
    Review(
      profilePicUrl: 'images/male2.jpg',
      name: 'Jane Smith',
      date: DateTime(2023, 7, 20),
      rating: 5.0,
      content: 'Nulla vel magna et nisi euismod fermentum vel at leo.',
    ),
    Review(
      profilePicUrl: 'images/male3.jpg',
      name: 'Bob Johnson',
      date: DateTime(2023, 7, 25),
      rating: 3.0,
      content: 'Vivamus et dolor nec felis malesuada varius.',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarAll(title: 'View Reviews'),
        bottomNavigationBar: BottomNavBar(),
        resizeToAvoidBottomInset: false,
        body: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ReviewCard(review: review),
            );
          },
        ),
      ),
    );
  }
}