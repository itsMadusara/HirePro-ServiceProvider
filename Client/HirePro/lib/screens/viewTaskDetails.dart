import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/CheckIconLarge.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_pro/widgets/SmallArrowButton.dart';
import 'package:hire_pro/widgets/MainCard.dart';

class ViewTaskDetails extends StatefulWidget {
  const ViewTaskDetails({super.key});

  @override
  State<ViewTaskDetails> createState() => _ViewTaskDetailsState();
}

class _ViewTaskDetailsState extends State<ViewTaskDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                    children: [
                      
                  ],
                )

                  ],
                ),
              ),
            )
        )
    );
  }
}
