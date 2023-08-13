import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainCard.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<String> images = ['', ''];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            MainCard(
                550,
                double.infinity,
                kMainGrey,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ContentSection('Task', 'Plumbing'),
                    ContentSection(
                        'Where', 'Galle road,Katukurunda,Kalutara south'),
                    ContentSection('Schedule Date', '2023-10-2'),
                    ContentSection('Schedule Time', '14:00'),
                    Column(
                      children: [
                        ContentSection('Description', ''),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 65, 65, 65),
                              width: 1.0,
                            ),
                          ),
                          margin:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Text(
                              textAlign: TextAlign.justify,
                              "Hi there! I'm in need of a skilled plumber to help me with an urgent issue at my home. My kitchen faucet has been leaking persistently, and it's causing water wastage and an annoying dripping sound. I've tried tightening the faucet handle, but the leak hasn't stopped.Hi there! I'm in need of a skilled plumber to help me with an urgent issue at my home. My kitchen faucet has been leaking persistently, and it's causing water wastage and an annoying dripping sound. I've tried tightening the faucet handle, but the leak hasn't stopped.",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    ContentSection('Goods Provided', 'Yes'),
                    ContentSection('Estimate (Rs.)', '2500-3500'),
                    ContentSection('Photos', ''),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: images.map((image) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              title: Text(image),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ContentSection extends StatelessWidget {
  String label;
  String data;
  ContentSection(this.label, this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Text(
                label,
                style: Knormal1.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                ':',
                style: Knormal1.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 10,
              child: Text(
                data,
                style: Knormal1,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
