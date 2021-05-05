class JadwalDb {

  int id;
  String _mapel;
  String _jenjang;
  String _hari;

  JadwalDb(this._mapel, this._jenjang, this._hari);

  JadwalDb.map(dynamic obj) {
    this._mapel = obj["mapel"];
    this._jenjang = obj["jenjang"];
    this._hari = obj["hari"];
  }

  String get mapel => _mapel;

  String get jenjang => _jenjang;

  String get hari => _hari;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["mapel"] = _mapel;
    map["jenjang"] = _jenjang;
    map["hari"] = _hari;

    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }
}
