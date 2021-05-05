import 'fragments/home_fragment.dart';
import 'fragments/aboutus_fragament.dart';
import 'fragments/data.dart';
import 'package:flutter/material.dart';
import 'package:tugas_crud/jadwal/mainjadwal.dart';
import 'package:tugas_crud/todo/main.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Data", Icons.date_range),
    new DrawerItem("About Us", Icons.people_outline),
    new DrawerItem("Schedule", Icons.calendar_today_outlined),
    new DrawerItem("To-Do", Icons.schedule_send)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
      return new Dashboard();
      case 1:
        return new Home();
      case 2:
        return new Aboutus();
      case 3:
        return new MyApp();
      case 4:
        return new TodoApp();

      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        backgroundColor: Colors.black,
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("user"), accountEmail: new Text("example@gmail.com"),currentAccountPicture: CircleAvatar(
              backgroundColor:
              Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.black
                  : Colors.white,
              child: Text(
                "U",
                style: TextStyle(fontSize: 40.0),
              ),
            ),),
            new Column(children: drawerOptions),
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}