import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterAssessment/todomodel.dart';
import 'package:flutterAssessment/todoform.dart';
import 'package:flutterAssessment/todolist.dart';

import 'dart:convert';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: TextTheme(body1: TextStyle(fontSize: 12.0)),
      ),

      home: toDoList(title: 'To-Do List'),
    );
  }
}

class toDoList extends StatefulWidget {
  toDoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _toDoListState createState() => _toDoListState();
}

class _toDoListState extends State<toDoList> {
  var initialToDo = <ToDo>[]
    ..add(new ToDo("Automated Testing Script","2020-01-22", "2020-01-24", false, ""));

  _showNewToDoForm() async {
    ToDo toDo = await Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new AddToDoFormPage();
        },
      ),
    );
    if (toDo != null) {
      setState(() {
          initialToDo.add(toDo);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Align(
        alignment: Alignment.bottomLeft,
        child: Text(widget.title,style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Color.fromRGBO(253, 177, 0, 1),
      ),
      body: Center(
        child: new Center(
          child: new ToDoList(initialToDo),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewToDoForm,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
