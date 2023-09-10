import 'package:flutter/material.dart';
import 'package:hire_pro/Models/ServiceProvider.dart';
import 'package:hire_pro/services/api.dart';

class SPProvider extends ChangeNotifier {
  SP? _serviceProvider;
  bool isLoading = false;
  Api api = Api();

  SP? get serviceProviderData => _serviceProvider!;
  Future<void> getSPData() async {
    isLoading = true;
    notifyListeners();
    final response = await api.getData();
    print(response);
    _serviceProvider = response;
    isLoading = false;
    notifyListeners();
  }

  // void changeName(String name) async {
  //   isLoading = true;
  //   notifyListeners();
  //   _serviceProvider?.name = name;
  //   await api.changeName(name);
  //   isLoading = false;
  //   notifyListeners();
  // }

}