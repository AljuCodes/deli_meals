import 'package:deli_meals/models/dummy_data.dart';
import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/category_meals_screen.dart';
import 'package:deli_meals/screens/filtered_screen.dart';
import 'package:deli_meals/screens/meal_detail_screen.dart';
import 'package:deli_meals/screens/tab_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _favoriteMeals = [];
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setfilters(Map<String, bool> selectedFilters) {
    setState(() {
      print(selectedFilters);
      _filters = selectedFilters;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
      for (int i = 0; i < _availableMeals.length; i++,) {
        print(_availableMeals[i].title);
      }
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals
        .indexWhere((favoriteMeals) => favoriteMeals.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS
            .firstWhere((favoriteMeals) => favoriteMeals.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((favoriteMeals) => favoriteMeals.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        // ignore: deprecated_member_use
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        // fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              _toggleFavorite,
              _isMealFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setfilters),
        TabsScreen.routeName: (ctx) => TabsScreen(_favoriteMeals)
      },
      onGenerateRoute: (settings) {
        // ignore: avoid_print
        // print(settings.arguments);
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
