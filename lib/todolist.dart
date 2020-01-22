import 'package:flutter/material.dart';
import 'package:flutterAssessment/todocard.dart';
import 'package:flutterAssessment/todomodel.dart';

class ToDoList extends StatelessWidget {
  final List<ToDo> todo;

  ToDoList(this.todo);

  ListView _buildList(context) {
    return new ListView.builder(
      itemCount: todo.length,
      itemBuilder: (context, int) {
        return new ToDoCard(todo[int]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
