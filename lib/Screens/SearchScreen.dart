import 'package:flutter/material.dart';
import 'package:hungryflutter/Models/Meal.dart';
import 'package:hungryflutter/Models/UIConstants.dart';
import 'package:hungryflutter/custom_widgets/FoodView.dart';
import 'package:hungryflutter/services/RecipeService.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQueryText;

  bool _hasData = false;
  bool _isLoading = false;

  SearchResult result = SearchResult(meals : []);
  
  getData() async {
    setState(() {
      _hasData = false;
      _isLoading = true;
    });
    result = await RecipeService.getRecipes(_searchQueryText);
    setState(() {
      _isLoading = false;
      _hasData = true;
    });
    print(result.meals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hungry Search"),
        backgroundColor: UIConstants.scaffoldColor,
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Visibility(
            visible: !_hasData,
            child: blankBox(),
          ),
          Expanded(
            child: Visibility(
              visible: _hasData && !_isLoading,
              child: FoodView(result.meals),
            ),
          ),
          getSearchWidget(),
        ],
      )),
    );
  }

  getSearchWidget() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Search"),
              onChanged: (value) {
                _searchQueryText = value;
              },
            ),
          ),
          IconButton(
            onPressed: () {
              getData();
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
    );
  }

  blankBox() {
    return Expanded(
      child: Center(
        child: Container(
          child: Visibility(
              child: (_isLoading) ? CircularProgressIndicator() : Icon(
            Icons.search,
            size: 40,
            color: Colors.indigo,
          )),
        ),
      ),
    );
  }
}
