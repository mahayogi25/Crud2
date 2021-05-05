import 'package:tugas_crud/jadwal/database/database_hepler.dart';
import 'package:tugas_crud/jadwal/database/model/db.dart';

import 'dart:async';


abstract class HomeContract {
  void screenUpdate();
}

class HomePresenter {

  HomeContract _view;

  var db = new DatabaseHelper();

  HomePresenter(this._view);

  //method untuk menghapus
  delete(JadwalDb jadwal) {
    var db = new DatabaseHelper();
    db.deleteUsers(jadwal);
    updateScreen();
  }
  //mendapatkan database
  Future<List<JadwalDb>> getUser() {
    return db.getUser();
  }

  updateScreen() {
    _view.screenUpdate();

  }


}
