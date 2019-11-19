import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'glutten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favouriteMeals = [];

  void _setFilters(Map<String, bool> newFilters) {
    setState(() {
      filters = newFilters;
      availableMeals = DUMMY_MEALS.where((meal) {
        if(filters['glutten'] && !meal.isGlutenFree ) {
          return false;
        }
        if(filters['lactose'] && !meal.isLactoseFree ) {
          return false;
        }
        if(filters['vegan'] && !meal.isVegan ) {
          return false;
        }
        if(filters['vegetarian'] && !meal.isVegetarian ) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _setFavourite(mealId) {
    var existingIndex = favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0) {
      setState(() {
        favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavourite(mealId) {
    return favouriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
//      home: CategoriesScreen(),
      routes: {
        '/': (_) => TabsScreen(favouriteMeals),
        CategoryMealsScreen.routeName: (_) => CategoryMealsScreen(availableMeals),
        MealDetails.routeName: (_) => MealDetails(_setFavourite, _isFavourite),
        FiltersScreen.routeName: (_) => FiltersScreen(filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
