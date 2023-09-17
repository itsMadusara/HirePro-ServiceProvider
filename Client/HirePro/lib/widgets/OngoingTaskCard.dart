import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/screens/reviews.dart';
import 'package:hire_pro/services/dateTimeFormatted.dart';
import 'package:hire_pro/widgets/StarRatingIndicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class OngoingTaskCard extends StatefulWidget {
  final String location;
  final String date;
  final String time;
  final String customerName;
  final double price;
  final double rating;
  final String image;
  final double progress;

  OngoingTaskCard(this.location, this.date, this.time, this.customerName, this.price, this.rating, this.image, this.progress);

  @override
  _OngoingTaskCardState createState() => _OngoingTaskCardState();
}

class _OngoingTaskCardState extends State<OngoingTaskCard> {
  double progress = 0.5; // Initial progress value

  void updateProgress(double newProgress) {
    setState(() {
      progress = newProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
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
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex:4,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 10, 8.0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 24,
                            ),
                            SizedBox(width: 10,),
                            Container(
                              child: Expanded(
                                child: Text(
                                  widget.location,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              widget.date + ' | ' + widget.time,
                              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 3,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.customerName,
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Customer",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              // Add more Text widgets here if needed
                            ],
                          ),
                        ),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text('Job Price', style: TextStyle(color: Colors.orange, fontSize: 10)),
                                Text('Rs.' + widget.price.toString(), style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20)),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Customer Rating', style: TextStyle(color: Colors.orange, fontSize: 10)),
                                StarRatingIndicator(widget.rating, 14, Colors.black)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 3,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: widget.progress, // percent filled
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 3,),
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
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.image),
                      ),
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