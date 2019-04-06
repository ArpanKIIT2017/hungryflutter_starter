import 'package:flutter/material.dart';
import 'package:hungryflutter/Models/UIConstants.dart';
import 'package:hungryflutter/Screens/SearchScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: UIConstants.scaffoldColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  List<Widget> _children = [
    Container(),
    SearchScreen(),
    Container()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home),),
          BottomNavigationBarItem(title: Text("Search"), icon: Icon(Icons.search),),
          BottomNavigationBarItem(title: Text("Categories"), icon: Icon(Icons.category))
        ],
        currentIndex: _currentIndex,),
    );
  }
}

