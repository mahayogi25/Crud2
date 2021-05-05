import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tugas_crud/jadwal/add_user_dialog.dart';
import 'package:tugas_crud/jadwal/database/model/db.dart';
import 'package:tugas_crud/jadwal/home_presenter.dart';
import 'package:tugas_crud/jadwal/list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements HomeContract {
  HomePresenter homePresenter;

  //state awal
  @override
  void initState() {
    super.initState();
    homePresenter = new HomePresenter(this);
  }

  displayRecord() {
    setState(() {});
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
          ],
        ),
      ),
    );
  }

  //untuk menampilkan allert dialog
  Future _openAddUserDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddUserDialog().buildAboutDialog(context, this, false, null),
    );

    setState(() {});
  }

 

 //menampilkan data yang telah dimasukkan
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     backgroundColor: Colors.black,
      body: new FutureBuilder<List<JadwalDb>>(
        future: homePresenter.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData
              ? new JadwalList(data,homePresenter)
              : new Center(child: new CircularProgressIndicator());
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
          onPressed: _openAddUserDialog,
      ),
    ); 
  }

  @override
  void screenUpdate() {
    setState(() {});
  }
}
