import 'animasi.dart';
import 'package:flutter/material.dart';
import 'package:tugas_crud/model/user.dart';
import 'package:tugas_crud/service/user_service.dart';
import 'package:tugas_crud/widget/form_label.dart';

class FormUser extends StatefulWidget {

  @override
  _FormUserState createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
   UserApiService apiService;

  static const genders = User.genders; // memanggil data dari domain
  static const grades = User.grades; //  memanggil data dari domain

  //menggunakan global key
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool _autovalidate = false;
  // jarak antar form
  double _gap = 16.0;
  // focus node
  FocusNode _fullnameFocus, _phoneFocus;
  // deklarasi variabel value null
  String _fullname, _gender, _grade, _phone;

  //dekalrasi nilai untuk grades
  final List<DropdownMenuItem<String>> _gradeItems = grades
    .map((String val) => DropdownMenuItem<String>(
          value: val,
          child: Text(val.toUpperCase()),
        ))
    .toList();
    //dekalrasi nilai untuk gender
  final List<DropdownMenuItem<String>> _genderItems = genders
    .map((String val) => DropdownMenuItem<String>(
          value: val,
          child: Text(val.toUpperCase()),
        ))
    .toList();

//state awal untuk setiap field
  @override
  void initState() {
    super.initState();
    _gender = 'pria';
    _fullnameFocus = FocusNode();
    _phoneFocus = FocusNode();
    apiService = UserApiService();
  }

  @override
  void dispose() {
    // menghapus focos note jika form sudah diinputkan
    _fullnameFocus.dispose();
    _phoneFocus.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

//method untuk menampilkan pesan
  _showSnackBar(message){
    final snackbar = SnackBar(content: Text(message),);
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

//menampilkan halaman form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.black,
              Colors.black,
              Colors.black
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text("FORM Data Input", style: TextStyle(color: Colors.white, fontSize: 40),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        FadeAnimation(1.4, Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                                  child: Form(
                                    // key form untuk csrf
                                    key: _formKey,
                                    autovalidate: _autovalidate,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextFormField(
                                            focusNode: _fullnameFocus,
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Nama Lengkap',
                                            ),
                                            onSaved: (String value) {
                                              // will trigger when saved
                                              print('onsaved _fullname $value');
                                              _fullname = value;
                                            },
                                            onFieldSubmitted: (term) {
                                              // process
                                            },
                                            validator: (val) {
                                              if(val.isEmpty){
                                                return "Nama lengkap wajib diisi";
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: _gap,
                                          ),
                                          TextFormField(
                                            focusNode: _phoneFocus,
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.phone,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'No. Hp',
                                            ),
                                            onSaved: (String value) {
                                              // will trigger when saved
                                              print('onsaved _hone $value');
                                              _phone = value;
                                            },
                                            onFieldSubmitted: (term) {
                                              // process
                                            },
                                            validator: (val) {
                                              if(val.isEmpty){
                                                return "No hp wajib diisi";
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: _gap,
                                          ),
                                          FormLabel('Jenis Kelamin'),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: DropdownButton(
                                              value: _gender,
                                              hint: Text('Jenis Kelamin'),
                                              items: _genderItems,
                                              isExpanded: true,
                                              onChanged: (String value) {
                                                setState(() {
                                                  _gender = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: _gap,
                                          ),
                                          FormLabel('Jenjang'),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: DropdownButton(
                                              value: _grade,
                                              hint: Text('Pilih jenjang'),
                                              items: _gradeItems,
                                              isExpanded: true,
                                              onChanged: (String value) {
                                                setState(() {
                                                  _grade = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                 )),
                                SizedBox(height: 40,),
                                FadeAnimation(1.6, Container(
                                  margin: const EdgeInsets.only(top: 6.0),
                                  child : new RaisedButton(
                                  onPressed: () {
                                  final form = _formKey.currentState;
                                  //validasi form
                                  if (form.validate()) {
                                    // Processing data.
                                    form.save();
                                    User _user = User();

                                    if(_grade == null){
                                      _showSnackBar("Jenjang tidak boleh kosong");
                                    } else if(_gender == null){
                                      _showSnackBar("Gender tidak boleh kosong");
                                    } else {
                                      _user.fullName = _fullname;
                                      _user.grade = _grade;
                                      _user.gender = _gender;
                                      _user.phone = _phone;
                                      print(_user);

                                      // snackbar success dan error
                                      final onSuccess = (Object success) => Navigator.pop(context);
                                      final onError = (Object error) => _showSnackBar("Tidak bisa simpan data");
                                      
                                      apiService.createUser(_user).then(onSuccess).catchError(onError);
                                    }
                                  } else {
                                    setState(() {
                                      _autovalidate = true;
                                    });
                                  }
                                },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)
                            ),
                            elevation: 0.0,
                              padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.orangeAccent,Colors.orange]
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                
                                constraints: BoxConstraints(minWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text("Input",
                                style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w700),
                                ),
                              ),
                            )
                          ),
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}