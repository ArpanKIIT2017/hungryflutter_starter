import 'package:flutter/material.dart';
import 'package:hungryflutter/Models/Meal.dart';
import 'package:hungryflutter/Screens/MealDetail.dart';

class FoodView extends StatefulWidget {
  final List<Meal> meals;

  FoodView(this.meals);

  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.meals.length,
      itemBuilder: (context, index) {
        var meal = widget.meals[index];
        return getMealView(meal);
      },
    );
  }

  getMealView(Meal meal) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(meal.strMealThumb), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child:
              IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
        ),
        Positioned(
          bottom: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white54,
            ),
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: Text(
                meal.strMeal,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              subtitle: (meal.strArea != null)
                  ? Text(
                      meal.strArea,
                      style: TextStyle(color: Colors.black),
                    )
                  : null,
              trailing: FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) {
                      return MealDetail(meal);
                    }));
                },
                icon: Icon(
                  Icons.view_list,
                  color: Colors.black,
                ),
                label: Text(
                  "View Recipe",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
