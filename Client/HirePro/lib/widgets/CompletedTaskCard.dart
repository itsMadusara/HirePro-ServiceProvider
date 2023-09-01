import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/reviews.dart';
import 'package:hire_pro/services/dateTimeFormatted.dart';
import 'package:hire_pro/widgets/StarRatingIndicator.dart';

class CompletedTaskCard extends StatelessWidget {
  CompletedTaskCard(this.location, this.date, this.customerName, this.price, this.rating, this.image);
  final String location;
  final String date;
  final String customerName;
  final double price;
  final double rating;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(-5, 0),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      // margin: EdgeInsets.symmetric(horizontal: 10),
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex:4,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10, 8.0, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerName,
                            overflow: TextOverflow.ellipsis, // Add ellipsis overflow
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          StarRatingIndicator(rating, 16, Colors.black),
                          Text(
                            "Finish By: " + date,
                            style: TextStyle(fontSize: 11, color: Colors.black),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 24,
                              ),
                              SizedBox(width: 7,),
                              Container(
                                child: Expanded(
                                  child: Text(
                                    location,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Job Price', style: TextStyle(color: kMainYellow, fontSize: 10)),
                              Text( 'Rs.'+price.toString(),style: TextStyle(color: kMainYellow, fontWeight: FontWeight.bold, fontSize: 20)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'View More',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 15,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/task2.png'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
        // ),
      ),
    );
  }
}


