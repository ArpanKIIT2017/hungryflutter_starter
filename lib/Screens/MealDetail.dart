import 'package:flutter/material.dart';
import 'package:hungryflutter/Models/Meal.dart';
import 'package:url_launcher/url_launcher.dart';

class MealDetail extends StatefulWidget {
  final Meal meal;
  MealDetail(this.meal);

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(widget.meal.strMeal),
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Image.network(
                widget.meal.strMealThumb,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: Text(widget.meal.strMeal),
                subtitle: (widget.meal.strArea != null)
                    ? Text(
                  widget.meal.strArea,
                  style: TextStyle(color: Colors.white),
                )
                    : Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Text(
                  "Ingredients",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              (widget.meal.strYoutube != null &&
                  widget.meal.strYoutube.isNotEmpty) ? Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16.0, right: 16),
                  child: RaisedButton(
                    onPressed: () {
                      _launchURL();
                    },
                    child: Text(
                        "YouTube Video", style: TextStyle(fontSize: 17,)),
                  )) : Container(),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: widget.meal.ingredients.length,
                itemBuilder: (context, index) {
                  var ingredient = widget.meal.ingredients[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Table(
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Text(ingredient.name),
                          ),
                          TableCell(
                            child: Text(ingredient.measure),
                          ),
                        ]),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16.0, right: 16),
                child: Text(
                  "Instructions",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding:
                EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
                child: Text(widget.meal.strInstructions),
              )
            ]),
          )
        ],
      ),
    );
  }
  _launchURL() async {
    var url = widget.meal.strYoutube;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}