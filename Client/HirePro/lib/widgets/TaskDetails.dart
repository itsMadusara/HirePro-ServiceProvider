import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class TaskDetails extends StatefulWidget {
  final Map<String, dynamic> taskDescription; // Add this parameter
  const TaskDetails({super.key, required this.taskDescription}); // Add constructor

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<String> images = [];

  String toDate(String utcTimestamp) {
    DateTime dateTime = DateTime.parse(utcTimestamp);
    String formattedDateTime = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDateTime;
  }

  String toTime(String utcTimestamp) {
    DateTime dateTime = DateTime.parse(utcTimestamp);
    String formattedDateTime = DateFormat('HH:mm').format(dateTime);
    return formattedDateTime;
  }

  Future<List<String>> getImagesInFolder(String id) async {
    try {
      List<String> images1 = [];
      final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

      firebase_storage.Reference ref = storage.ref('/task_images/$id');
      final ListResult result = await ref.listAll();

      for (final firebase_storage.Reference item in result.items) {
        final String downloadURL = await item.getDownloadURL();
        images1.add(downloadURL);
        print('Download URL for ${item.fullPath}: $downloadURL');
      }
      return images1;
    } catch (e) {
      print('Error getting number of images: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> description = widget.taskDescription;
    String category = description['category'];
    String tasks = '';
    if (category == 'HairDressing' || category == 'HouseCleaning'){
      List<dynamic> taskList = description['jobTasks'];
      for (var item in taskList) {
        tasks = tasks + item['task'];
        if(taskList.last == item){
          continue;
        }
        tasks = tasks + ' , ';
      }
    } else {
      List<dynamic> taskList = description['jobTasks'];
      for (var item in taskList) {
        tasks = tasks + item['areaInSquareMeter'].toString();
        tasks = "${tasks} Square Meters to Lawn Mow";
      }
    }

    if (category == 'HairDressing'){
      category = 'Hair Dressing';
    } else if (category == 'HouseCleaning'){
      category = 'House Cleaning';
    } else {
      category = 'Lawn Moving';
    }
    print(description);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            MainCard(
                650,
                double.infinity,
                kMainGrey,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ContentSection('Task', 'Plumbing'),
                    ContentSection('Task', category),
                    ContentSection(
                        'Where', description['serviceValue']['location']),
                    ContentSection('Schedule Date', toDate(description['serviceValue']['posted_timestamp'])),
                    ContentSection('Schedule Time', toTime(description['serviceValue']['posted_timestamp'])),
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
                              description['serviceValue']['description'],
                              // "Hi there! I'm in need of a skilled plumber to help me with an urgent issue at my home. My kitchen faucet has been leaking persistently, and it's causing water wastage and an annoying dripping sound. I've tried tightening the faucet handle, but the leak hasn't stopped.Hi there! I'm in need of a skilled plumber to help me with an urgent issue at my home. My kitchen faucet has been leaking persistently, and it's causing water wastage and an annoying dripping sound. I've tried tightening the faucet handle, but the leak hasn't stopped.",
                              textAlign: TextAlign.justify,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    ContentSection('Goods Provided', 'Yes'),
                    ContentSection('Estimate (Rs.)', description['serviceValue']['estmin'] + '-' + description['serviceValue']['estmax']),
                    ContentSection('Tasks', tasks),
                    ContentSection('Photos', ''),
                    Expanded(
                      child: FutureBuilder<List<String>>(
                          future: getImagesInFolder(description['serviceValue']['id']),
                          builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error loading images');
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Text('No images available');
                          } else {
                            images = snapshot.data!;
                            return GridView.count(
                              crossAxisCount: 2,
                              children: images.map((image) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    )
                    // Expanded(
                    //   child: isLoading ? Center(child: CircularProgressIndicator()) :
                    //   GridView.count(
                    //     crossAxisCount: 2,
                    //     children: images.map((image) {
                    //       return Card(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20),
                    //         ),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(20),
                    //           child: Image.asset(
                    //             image,
                    //             fit: BoxFit.cover,
                    //           ),
                    //         ),
                    //       );
                    //     }).toList(),
                    //   ),
                    // )
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
