import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/reviews.dart';
import 'package:hire_pro/services/dateTimeFormatted.dart';
import 'package:hire_pro/widgets/StarRatingIndicator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpcomingTaskCard extends StatelessWidget {
  UpcomingTaskCard(this.location, this.date,this.time, this.customerName, this.jobPrice, this.rating, this.image);
  final String location;
  final String date;
  final String time;
  final String customerName;
  final double jobPrice;
  final double rating;
  final String image;
  bool isLoading = true;
  String imageURL = '';

  Future<String> getImageUrl(String id) async {
    try {
      await Firebase.initializeApp();
      final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference ref = storage.ref('/task_images/$id/0.png');
      final String downloadURL = await ref.getDownloadURL();
      // imageURL = downloadURL;
      // isLoading = false;
      print(imageURL);
      return downloadURL;
    } catch (e) {
      print('Error retrieving image from Firebase Storage: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    getImageUrl(image);

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
                            "Starts: " + date + " | " + time,
                            style: TextStyle(fontSize: 11, color: Colors.black),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 20,
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
                              Text( 'Rs.'+jobPrice.toString(),style: TextStyle(color: kMainYellow, fontWeight: FontWeight.bold, fontSize: 15)),
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
                  child: FutureBuilder<String>(
                    future: getImageUrl(image),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error loading image');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('Image not available');
                      } else {
                        String imageURL = snapshot.data!;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageURL),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                // Expanded(
                //   flex: 3,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       image: DecorationImage(
                //         fit: BoxFit.cover,
                //         image: AssetImage('images/lawn1.jpg'),
                //       ),
                //     ),
                // ),
                // ),
              ],
            ),
          ),
        ],
        // ),
      ),
    );
  }
}


