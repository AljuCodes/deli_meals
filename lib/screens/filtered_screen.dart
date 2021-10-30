import 'package:deli_meals/widget/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter",
        ),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text("filter Screen"),
      ),
    );
  }
}
