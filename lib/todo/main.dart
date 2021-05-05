import 'package:flutter/material.dart';
import 'package:tugas_crud/todo/Screens/todo_list.dart';
import 'package:tugas_crud/todo/Screens/todo_detail.dart';

class TodoApp extends StatelessWidget {

	@override
  Widget build(BuildContext context) {

    return MaterialApp(
	    title: 'TodoList',
	    debugShowCheckedModeBanner: false,
	    theme: ThemeData(
		    primarySwatch: Colors.blue
	    ),
	    home: TodoList(),
    );
  }
}