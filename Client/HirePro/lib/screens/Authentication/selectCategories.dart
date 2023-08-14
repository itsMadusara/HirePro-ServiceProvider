import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';
import 'package:hire_pro/widgets/MainCard.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import 'package:hire_pro/widgets/NavTop.dart';
import 'package:hire_pro/widgets/SearchBarWidget.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';

class SelectCategories extends StatefulWidget {
  const SelectCategories({super.key});

  @override
  State<SelectCategories> createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  List<Map<String, String>> _categories = [
    {
      'Gardening': 'images/gardener.png',
    },
    {
      'Plumbing': 'images/plumber.png',
    },
    {
      'Cleaning': 'images/cleaning.png',
    },
    {
      'Furniture': 'images/workspace.png',
    },
    {
      'Hair Cutting': 'images/hair-cut.png',
    },
    {
      'Lawn Moving': 'images/lawn-mower.png',
    },
    {
      'Painting': 'images/painting.png',
    },
  ];

  List<Map<String, String>> _filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    _filteredItems = _categories;
    super.initState();
  }

  void _filterItems(String searchText) {
    List<Map<String, String>> results = [];
    if (searchText.isEmpty) {
      results = _categories;
    } else {
      results = _categories
          .where((item) =>
          item.keys.first.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    setState(() {
      _filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBarBackButton(),
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Material(
                          elevation: 1,
                          shadowColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: TextField(
                              cursorColor: Colors.grey[600],
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Search Category',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 226, 226, 226))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 226, 226, 226)))),
                              onChanged: (value) => _filterItems(value)),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: _filteredItems.map((category) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    AssetImage(category.values.elementAt(0)))),
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(209, 0, 0, 0),
                                    ),
                                    width: double.infinity,
                                    height: 25,
                                    child: Text(category.keys.first,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
