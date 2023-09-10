import 'package:flutter/material.dart';
import 'package:hire_pro/Models/ServiceProvider.dart';
import 'package:hire_pro/services/api.dart';

class SPProvider extends ChangeNotifier {
  SP? _serviceProvider;
  bool isLoading = false;
  Api api = Api();
  // List<String> selectedCategories = [];

  final List<String> allCategories = [
    'Gardening',
    'Plumbing',
    'Cleaning',
    'Furniture Mounting',
    'Hair Dressing',
    'Lawn Moving',
    'Painting'
  ];

  final List<String> allCategoryImagePaths = [
    'images/cleaning.png',
    'images/hair-cut.png',
    'images/painting.png',
    'images/plumber.png',
    'images/cleaning.png',
    'images/hair-cut.png',
    'images/hair-cut.png',
  ];

  List<String> selectedImages = [];

  SP? get serviceProviderData => _serviceProvider!;
  Future<void> getSPData() async {
    isLoading = true;
    notifyListeners();
    final response = await api.getData();
    _serviceProvider = response;
    addSelectedCategoryImages();
    isLoading = false;
    notifyListeners();
  }

  // void updateSelectedCategories() {
  //   if (_serviceProvider != null) {
  //     selectedCategories = List.from(_serviceProvider!.category);
  //     print("Selected Categories:");
  //     for (String category in selectedCategories) {
  //       print(category);
  //     }
  //     addSelectedCategoryImages();
  //   }
  // }

  void addSelectedCategoryImages() {
    selectedImages.clear(); // Clear the existing selected images list

    for (String category in _serviceProvider!.category) {
      int index = allCategories.indexOf(category);
      if (index >= 0 && index < allCategoryImagePaths.length) {
        selectedImages.add(allCategoryImagePaths[index]);
      }
    }
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