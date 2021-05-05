import 'animasi.dart';
import 'package:flutter/material.dart';
import 'package:tugas_crud/model/user.dart';
import 'package:tugas_crud/service/user_service.dart';
import 'package:tugas_crud/widget/form_label.dart';

class FormEditUser extends StatefulWidget {

  final User user;
  final int id;

  FormEditUser({@required this.user, @required this.id, Key key}):super(key: key);

  @override
  _FormEditUserState createState() => _FormEditUserState();
}

class _FormEditUserState extends State<FormEditUser> {

  UserApiService apiService;

  static const genders = User.genders;
  static const grades = User.grades;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool _autovalidate = false;
  double _gap = 16.0;
  FocusNode _fullnameFocus, _phoneFocus;
  String _fullname, _gender, _grade, _phone;

  TextEditingController _fullnameController, _phoneController;

  final List<DropdownMenuItem<String>> _gradeItems = grades
    .map((String val) => DropdownMenuItem<String>(
          value: val,
          child: Text(val.toUpperCase()),
        ))
    .toList();

    final List<DropdownMenuItem<String>> _genderItems = genders
    .map((String val) => DropdownMenuItem<String>(
          value: val,
          child: Text(val.toUpperCase()),
        ))
    .toList();

  @override
  void initState() {
    super.initState();
    _gender = 'pria';
    _fullnameFocus = FocusNode();
    _phoneFocus = FocusNode();
    _fullnameController = TextEditingController();
    _phoneController = TextEditingController();

    if(widget.user != null && widget.id != null){
      _fullname = widget.user.fullName;
      _phone = widget.user.phone;
      _gender = widget.user.gender;
      _grade = widget.user.grade;

      _fullnameController.value = TextEditingValue(
        text: widget.user.fullName,
        selection: TextSelection.collapsed(offset: widget.user.fullName.length)
      );

       _phoneController.value = TextEditingValue(
        text: widget.user.phone,
        selection: TextSelection.collapsed(offset: widget.user.phone.length)
      );

    }

    apiService = UserApiService();
  }

  @override
  void dispose() {
    _fullnameFocus.dispose();
    _phoneFocus.dispose();
    _fullnameController.dispose();
    _phoneController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

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
                  FadeAnimation(1, Text("FORM Edit Data", style: TextStyle(color: Colors.white, fontSize: 40),)),
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
                                            controller: _fullnameController,
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
                                              _fullnameFocus.unfocus();
                                              FocusScope.of(context).requestFocus(_phoneFocus);
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
                                            controller: _phoneController,
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
                                              _phoneFocus.unfocus();
                                              FocusScope.of(context).requestFocus(_fullnameFocus);
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
                                  if (form.validate()) {
                                    form.save();
                                    User _user = User();

                                    if(_grade == null){
                                      _showSnackBar("tidak boleh kosong");
                                    } else if(_gender == null){
                                      _showSnackBar("tidak boleh kosong");
                                    } else {
                                      _user.fullName = _fullname;
                                      _user.grade = _grade;
                                      _user.gender = _gender;
                                      _user.phone = _phone;
                                      print(_user);
                                      final onSuccess = (Object success) => Navigator.pop(context);
                                      final onError = (Object error) => _showSnackBar("Tidak bisa ubah data");
                                      
                                      apiService.updateUser(id: widget.user.id, data: _user).then(onSuccess).catchError(onError);
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
                                child: Text("Simpan",
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