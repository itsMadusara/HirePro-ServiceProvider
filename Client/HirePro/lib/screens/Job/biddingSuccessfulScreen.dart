import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/CheckIconLarge.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';

class BiddingSuccessfulScreen extends StatefulWidget {
  const BiddingSuccessfulScreen({super.key});

  @override
  State<BiddingSuccessfulScreen> createState() => _BiddingSuccessfulScreenState();
}

class _BiddingSuccessfulScreenState extends State<BiddingSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: BottomNavBar(),
          appBar: AppBarBackButton(),
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckIconLarge(),
                    SizedBox(height: 25,),
                    Text(
                      'Bidding Successful',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 100),
                    Container(
                      height: 40,
                      width: 180,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35), // Set the border radius
                        color: Colors.grey[300], // Set your desired grey background color
                      ),
                      child: TextButton(
                        onPressed: () {Navigator.pushNamed(context, '/bidding_tasks');},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.black, // Set the icon color
                            ),
                            SizedBox(width: 20,),
                            Text(
                              'Back to Tasks',
                              style: TextStyle(color: Colors.black), // Set the text color
                            ),
                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            )
        )
    );
  }
}
