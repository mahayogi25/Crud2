import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas_crud/jadwal/database/database_hepler.dart';
import 'package:tugas_crud/jadwal/database/model/db.dart';
class AddUserDialog {
  final teMapel = TextEditingController();
  final teJenjang = TextEditingController();
  final teHari = TextEditingController();
  JadwalDb jadwal;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

//pengecekan value table
  Widget buildAboutDialog(
      BuildContext context, _myHomePageState, bool isEdit, JadwalDb jadwal) {
    if (jadwal != null) {
      this.jadwal=jadwal;
      teMapel.text = jadwal.mapel;
      teJenjang.text = jadwal.jenjang;
      teHari.text = jadwal.hari;
    }

    //menampilkan allert dialog
    return new AlertDialog(
      title: new Text(isEdit ? 'Edit' : 'Tambah Data'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          //merecord tex sebagai value untuk setiap field
          children: <Widget>[
            getTextField("Nama Mapel", teMapel),
            getTextField("Jenjang Mapel", teJenjang),
            getTextField("Hari", teHari),
            new GestureDetector(
              onTap: () {
                addRecord(isEdit);
                _myHomePageState.displayRecord();
                Navigator.of(context).pop();
              },
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(
                    isEdit?"Edit":"Add", EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }
  //melakukan pengeditan
  Future addRecord(bool isEdit) async {
    var db = new DatabaseHelper();
    var jadwal = new JadwalDb(teMapel.text, teJenjang.text, teHari.text);
    if (isEdit) {
      jadwal.setUserId(this.jadwal.id);
      await db.update(jadwal);
    } else {
      await db.saveUser(jadwal);
    }
  }
}
