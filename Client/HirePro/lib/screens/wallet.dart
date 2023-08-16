import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainButton.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:hire_pro/widgets/smallButton.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/widgets/BottomNavbar.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class Wallet extends StatefulWidget {
  @override
  State<Wallet> createState() => _WalletState();
}

String jsondata =
    '{"full_name": "John Doe", "email": "sachinimuthugala@gmail.com", "phone_number": "123-456-7890"}';
var userData = jsonDecode(jsondata);

class _WalletState extends State<Wallet> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBarTitle(title: 'Wallet',),
            bottomNavigationBar: BottomNavBar(),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: 1500,
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainCard(
                        300,
                        double.infinity,
                        kMainYellow,
                        Padding(
                          padding: EdgeInsets.all(18.0), // Adjust the padding as needed
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: ClipOval(
                                      child: Image.asset(
                                        'images/profile_pic.png',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15), // Adding some spacing between the image and text
                                  Text(
                                    'Hello, Sachini !',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Your Balance',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                                          SizedBox(height: 9,),
                                          Text('LKR 120,000',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900, color: Colors.white),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,)
                                        ],
                                      )
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[300],
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              icon: Icon(Icons.attach_money, color: Colors.black),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 6,),
                                        Text('Transfer', style: TextStyle(fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30,),
                              Row(
                                children: [
                                  Expanded(child: Walletcard('Service Fee','LKR 120,000')),
                                  SizedBox(width: 15,),
                                  Expanded(child: Walletcard('Tips','LKR 30,000')),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35,),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAllTransactionsPage()));
                                    Navigator.pushNamed(context,'/');
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline, // Add underline decoration
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            TransactionCards('images/profile_pic.png', 'Sachini Muthugala', '02 July, 2023', 'LKR 4,000'),
                            TransactionCards('images/profile_pic.png', 'Harini Samali', '05 July, 2023', 'LKR 7,000'),
                            TransactionCards('images/profile_pic.png', 'Chathu Silva', '10 July, 2023', 'LKR 15,000'),
                          ],
                        )
                      ),

                      SizedBox(height: 30,),
                      Container(
                          child: Column(
                            children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex:3,
                                child: Text(
                                  'Income',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: Text(
                                    'Month',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: Text(
                                    'Year',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],),
                            SizedBox(height: 25,),
                            IncomeDataChart()
                        ],)
                      ),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}

class Walletcard extends StatelessWidget {
  final String label;
  final String value;

  Walletcard(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // Shadow offset
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}


class TransactionCards extends StatelessWidget {
  final String imagePath;
  final String name;
  final String date;
  final String value;

  TransactionCards(this.imagePath, this.name, this.date, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            _buildGlassBackground(),
            _buildCardContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassBackground() {
    return Container(
      color: Colors.white.withOpacity(0.1), // Semi-transparent white
    );
  }

  Widget _buildCardContent() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200]?.withOpacity(0.2), // Grey background color with opacity
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // White background for the image
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class IncomeDataChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Adjust the height as needed
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Months')),
        primaryYAxis: NumericAxis(title: AxisTitle(text: 'Income(k)')),
        series: <ChartSeries>[
          LineSeries<SalesData, String>(
            dataSource: <SalesData>[
              SalesData('Jan', 35),
              SalesData('Feb', 28),
              SalesData('Mar', 34),
              SalesData('Apr', 32),
              SalesData('May', 40),
            ],
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}