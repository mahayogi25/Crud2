import 'package:flutter/material.dart';
import 'package:tugas_crud/model/user.dart';
import 'detail.dart';
import 'form.dart';
import 'package:tugas_crud/service/user_service.dart';
import 'package:tugas_crud/utils/capitalize.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() =>_HomeState();
}

class _HomeState extends State<Home> {
  
  //memanggil service api yang sudah dibuat untuk digunakan
  UserApiService apiService;
  @override
  void initState() {
    super.initState();
    apiService = UserApiService();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //menampilkan body dari halaman aplikasi
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "List Siswa",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Homeschooling",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Cari',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0, 
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(right: 30,),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.0, left: 24.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            
            //melakukan expansi untuk memisahkan bagian halaman
            new Expanded(
              //memanggil api service dan melakukan snapshot data untuk ditampilkan datanya
                child:  FutureBuilder(
                future: apiService.getUsers(),
               builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "Something wrong with message: ${snapshot.error.toString()}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<User> users = snapshot.data;
                  print(users);
                  return _buildListView(users);
                } else {
                  return Center(
                    child: Container(),
                  );
              
                }
               }
                )
              ),
              
            ]
        ),
        //menampilkan tombol tambah data yang melayang
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => FormUser()) 
            );
          }
        ),
    ); 
    
  }

  

  Widget _buildListView(List<User> users) {
    //membuat list view untuk meanmpilkan data dalam bentuk list
    return  ListView.separated(
      separatorBuilder: (BuildContext context, int i) => Divider(color: Colors.white),
      itemCount: users.length,
      itemBuilder: (context, index) {
        User user = users[index];
         return Column(children: [
          Card(
            color: Colors.grey,
            child: ListTile(
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => DetailUser(id: user.id, key: ValueKey(user.id))) 
            );
          },
          leading: CircleAvatar(
            radius: 24.0,
            backgroundImage: AssetImage('assets/images/${user.gender}.png'),
            backgroundColor: Colors.white,
          ),
                               
          title: Text(user.fullName),
          subtitle: Text(capitalize(user.grade)),
          trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14.0,
                  ),
           ),
          ),
        ],
      );
      }
        );

  }
  }