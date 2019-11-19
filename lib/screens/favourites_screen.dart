import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: favouriteMeals.length == 0
          ? Text('You don\'t have any favourite meals')
          : ListView.builder(
              itemBuilder: (context, index) {
                return MealItem(favouriteMeals[index]);
              },
              itemCount: favouriteMeals.length,
            ),
    );
  }
}
