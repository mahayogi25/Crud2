import 'package:flutter/material.dart';
import 'package:tugas_crud/utils/utils.dart';
import 'package:tugas_crud/utils/header.dart';
import 'data.dart';
import 'package:tugas_crud/jadwal/mainjadwal.dart';
import 'package:tugas_crud/todo/main.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //untuk menampilkan pesan selamat datang
  String welcomeMsg;
  //state pesan
    @override
  void initState() {
    super.initState();
    welcomeMsg = Utils.getWelcomeMessage();
  }

//menampilkan 4 menu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Header(
            msg: welcomeMsg,
          ),
        
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Wrap(
                  spacing:20,
                  runSpacing: 20.0,
                  children: <Widget>[
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(    
                        color: Colors.orangeAccent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: InkWell(
                            onTap: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => TodoApp()) 
                              );
                            },
                        child:Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                            children: <Widget>[
                              Image.asset("assets/todo.png",width: 64.0,),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Todo List",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                                ),
                              ),
                            ],
                            ),
                          )
                        ),
                          ),
                      ),
                    ),


                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Colors.orangeAccent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: InkWell(
                            onTap: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => Home()) 
                              );
                            },
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/note.png",width: 64.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Data Siswa",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        )
                      ),
                    ),
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Colors.orangeAccent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: InkWell(
                            onTap: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => MyApp()) 
                              );
                            },
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/calendar.png",width: 64.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Jadwal",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                ],
                              ),
                            )
                        )
                        ),
                      ),
                    ),
                    SizedBox(
                      width:160.0,
                      height: 160.0,
                      child: Card(

                        color: Colors.orangeAccent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child:Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Image.asset("assets/settings.png",width: 64.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}