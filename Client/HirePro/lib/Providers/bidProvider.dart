import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/Models/Bidding.dart';
import 'package:hire_pro/models/task.dart';
import 'package:hire_pro/services/api.dart';

class BidProvider extends ChangeNotifier {
  late Bid _bid;
  Api api = Api();
  void initialize() {
    _bid = Bid(
        amount: '',
        serviceId: '');
  }


  // void createLawnMowingTask(
  //     String additionalInfo,
  //     String amount,
  //     String serviceId,) {
  //   _bid.additionalInfo = additionalInfo;
  //   _bid.amount = amount;
  //   _bid.serviceId = serviceId;
  //   notifyListeners();
  // }

  void addBidding() {
    api.addBidding(
        _bid.additionalInfo = "",
        _bid.amount,
        _bid.serviceId,);
    notifyListeners();
  }

}
