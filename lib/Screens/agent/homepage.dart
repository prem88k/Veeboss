/*
import 'package:flutter/material.dart';

import 'AgentCreateJob.dart';
import 'ProfilePage.dart';
class AgentHomePage extends StatefulWidget {
  @override
  _AgentHomePageState createState() => _AgentHomePageState();
}

class _AgentHomePageState extends State<AgentHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
*/
/*
      bottomNavigationBar: BottomNavCustom(currentIndex),
*//*

      body:  callPage(currentIndex),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('My Account'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Order History'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Reservation History'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new HistoryPage();
      case 1:
        return new ProfilePage();
      default:
        return AgentHomePage();
    }
  }
}

class BottomNavCustom extends StatefulWidget {
  int currentIndex;
  BottomNavCustom(this.currentIndex);

  @override
  _BottomNavCustomState createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom> {
  Color backgroundColorNav = Colors.white;

  List<NavigationItem> items = [
    NavigationItem(Icon(Icons.home), Text('Home'), Colors.deepPurpleAccent),
    NavigationItem(Icon(Icons.history), Text('History'), Colors.pinkAccent),
    NavigationItem(Icon(Icons.person_outline), Text('Profile'), Colors.cyanAccent)
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: 50,
      width: isSelected ? 120 : 50,
      padding: isSelected ? EdgeInsets.only(left: 16, right: 16) : null,
      decoration: isSelected
          ? BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.all(Radius.circular(50)))
          : null,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  size: 24,
                  color: isSelected ? backgroundColorNav : Colors.black,
                ),
                child: item.icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: isSelected
                    ? DefaultTextStyle.merge(
                        style: TextStyle(color: backgroundColorNav),
                        child: item.title)
                    : Container(),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((item) {
          var itemIndex = items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.currentIndex = itemIndex;
              });
            },
            child: _buildItem(item,  widget.currentIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}

*/
