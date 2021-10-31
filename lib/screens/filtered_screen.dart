import 'package:deli_meals/widget/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function setFilter;
  final Map<String, bool> Filters;
  FiltersScreen(
    this.Filters,
    this.setFilter,
  );

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.Filters['gluten'] as bool;
    _lactoseFree = widget.Filters['lactose'] as bool;
    _vegan = widget.Filters['vegan'] as bool;
    _vegetarian = widget.Filters['vegetarian'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, dynamic updateValue) {
    return Column(
      children: [
        Divider(),
        SwitchListTile(
          value: currentValue,
          onChanged: updateValue,
          title: Text(title),
          subtitle: Text(description),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          title: Text(
            "Filter",
          ),
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.setFilter(selectedFilters);
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust Your Meal Values",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile("Gluten Free",
                    "only includes gluten-free meals", _glutenFree, (newvalue) {
                  setState(() {
                    _glutenFree = newvalue;
                  });
                  print(_glutenFree);
                }),
                _buildSwitchListTile(
                    "Lactose Free",
                    "only includes Lactose-free meals",
                    _lactoseFree, (newvalue) {
                  setState(() {
                    _lactoseFree = newvalue;
                  });
                  print(_lactoseFree);
                }),
                _buildSwitchListTile(
                    "vegetarian", "only includes vegetarian meals", _vegetarian,
                    (newvalue) {
                  setState(() {
                    _vegetarian = newvalue;
                  });
                  print(_vegetarian);
                }),
                _buildSwitchListTile(
                    "Vegan", "only includes Vegan meals", _vegan, (newvalue) {
                  setState(() {
                    _vegan = newvalue;
                  });
                  print(_vegan);
                }),
                Divider()
              ],
            )),
          ],
        ));
  }
}
