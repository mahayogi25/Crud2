import 'package:flutter/material.dart';
import 'package:tugas_crud/model/user.dart';
import 'edit_form.dart';
import 'package:tugas_crud/service/user_service.dart';
import 'package:tugas_crud/utils/capitalize.dart';

class DetailUser extends StatefulWidget {
  //deklarasi variable
  final int id;
  DetailUser({@required this.id, Key key}):super(key: key);

  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  //memanggil api service
  UserApiService apiService;
  User _user;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  //state untuk api service
  @override
  void initState() {
    apiService = UserApiService();
    super.initState();
  }
  //method untuk menampilan pesan/message
  _showSnackBar(message){
    final snackbar = SnackBar(content: Text(message),);
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      key: _scaffoldkey,
      //menampilkan appbar
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Detail"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
      body: Container(
        //menampilkan data siswa
        child: FutureBuilder<User>(
          future: apiService.getUserBy(widget.id),
          builder: (context, snapshot) {
            //jika gagal menghubungkan maka akan ditampilkan tampilan loading screen
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return LinearProgressIndicator();
              //jika berhasil dihubungkan, maka akan ditampilkan data siswa yang dipilih
            } else if (snapshot.connectionState == ConnectionState.done) {
              _user = snapshot.data;
              //jika id siswa tidak sama dengan 0, maka akan ditampilkan datanya
              if(_user.id != 0){
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Image.asset(
                        'assets/images/${_user.gender}.png',
                        width: 150.0,
                        height: 150.0,
                      ),
                    ),
                    Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.account_box, color: Colors.orange),
                      title: Text(_user.fullName),
                      subtitle: const Text('Nama'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.0,
                      ),
                    ),
                    ),
                    Card(
                    color: Colors.white,
                    child:ListTile(
                      leading: Icon(Icons.phone, color: Colors.blue),
                      title: Text(_user.phone),
                      subtitle: const Text('No.Hp'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.0,
                      ),
                    ),
                    ),
                    Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.label, color: Colors.green),
                      title: Text(capitalize(_user.gender)),
                      subtitle: const Text('Gender'),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.0,
                      ),
                    ),
                    ),
                    Card(
                    color: Colors.white,                      
                    child: ListTile(
                      leading: Icon(Icons.school,  color: Colors.red),
                      title: Text(_user.grade.toUpperCase()),
                      subtitle: const Text('Grade'),
                       trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.0,
                      ),
                    ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         ElevatedButton(
                          child: Text(
                            "EDIT".toUpperCase(),
                            style: TextStyle(fontSize: 14)
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.blueAccent)
                              )
                            )
                          ),
                          onPressed: () {
                             Navigator.push(context, 
                              MaterialPageRoute(builder: (BuildContext context) => FormEditUser(
                                user: _user,
                                id: widget.id),
                                ),
                              );
                          }
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          child: Text(
                            "HAPUS".toUpperCase(),
                            style: TextStyle(fontSize: 14)
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.red)
                              )
                            )
                          ),
                          onPressed: (){
                            //jika data berhasil terhapus
                            final onSuccess = (Object obj) async {
                              _showSnackBar("Data Terhapus");
                              await Future.delayed(Duration(seconds: 2)).then((Object obj) => Navigator.pop(context));
                            };
                            //jika gagal terhapus
                            final onError = (Object obj) => _showSnackBar("Gagal");
                            apiService.deleteUser(id: widget.id).then(onSuccess).catchError(onError);
                          },
                        )
                      ]
                    )
                  ],
                );
              } else {
                //jika tidak, maka akan keluar pesan gagal
                return Text("Data Tidak Ditemukan");
              }
          
            } else {
              return Center(
                child: Container(),
              );
            }
          }
        ),
        
      ),
    );
  }
}