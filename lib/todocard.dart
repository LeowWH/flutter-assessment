import 'package:flutter/material.dart';
import 'package:flutterAssessment/todomodel.dart';
import 'package:flutterAssessment/todoform.dart';
import 'dart:async';
import 'dart:convert';

import 'package:date_format/date_format.dart';

class ToDoCard extends StatefulWidget {
  final ToDo todo;

  ToDoCard(this.todo);

  @override
  ToDoCardState createState() {
    return new ToDoCardState(todo);
  }
}

class ToDoCardState extends State<ToDoCard> {
  ToDo todo;
  Timer _timer;
  var _status = "";

  ToDoCardState(this.todo);

  void initState() {
    startCount();
    super.initState();
  }

  void startCount() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          var diff = DateTime.parse(todo.enddate).difference(DateTime.now());
          todo.lefttime = _printDuration(diff);
          if(todo.status == false){
            _status = "Incomplete";
          }else{
            _status = "Completed";
          }
        },
      ),
    );
  }

  String _printDuration(Duration duration) {
        String Minutes = duration.inMinutes.remainder(60).toString();
        String Days = duration.inDays.remainder(60).toString();
        String Hours = (duration.inHours - (int.parse(Days) * 24)).toString();
        if(int.parse(Minutes) < 0 && (int.parse(Hours) < 0 || int.parse(Days) < 0)){
          return "Expired";
        }
        return "$Days d $Hours hrs $Minutes min";
  }


  Widget get toDoCard {
    return new Positioned(
      // right: 0.0,
      // padding: const EdgeInsets.all(10.0),
      child: new Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                 spreadRadius: -5.0,
                // offset: Offset(0.0, 0.0)
            )
          ],
        // color: Colors.black54
      ),
        width: MediaQuery.of(context).size.width,
        // height: 115.0,
        child: new Card(
          color: Colors.white,
          child: new Column(
            children: [
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: new Text(widget.todo.title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text("Start Date")
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: new Text(widget.todo.startdate,style: TextStyle(fontWeight: FontWeight.bold))
                                )
                              ]
                        ),
                        new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text("End Date")
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: new Text(widget.todo.enddate,style: TextStyle(fontWeight: FontWeight.bold))
                                )
                              ]
                        ),
                        new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text("Time left")
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: new Text(widget.todo.lefttime,style: TextStyle(fontWeight: FontWeight.bold))
                                )
                              ]
                        ),
                      ]
                    )
                  ],
                ),
              ),
              new Container(
                color: Color.fromRGBO(224, 220, 196, 1),               
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children:[
                        new Padding(padding: const EdgeInsets.only(left: 10.0)),
                        new Text("Status"),
                        new Padding(padding: const EdgeInsets.only(left: 5.0)),
                        new Text(_status,style: TextStyle(fontWeight: FontWeight.bold)),
                      ]
                    ),
                    new Row(
                      children:[
                        new Text("Tick if completed"),
                        new Padding(padding: const EdgeInsets.only(left: 5.0)),
                        Checkbox(
                          value: widget.todo.status,
                          onChanged: (bool value) {
                              setState(() {
                                  widget.todo.status = value;
                                  if(todo.status == false){
                                    _status = "Incomplete";
                                  }else{
                                    _status = "Completed";
                                  }
                              });
                          },
                        ),
                        new Padding(padding: const EdgeInsets.only(left: 10.0)),
                      ]
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      // onTap: () => showToDoDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: new Container(
          // height: 115.0,
          child: new Stack(
            children: <Widget>[
              toDoCard,
            ],
          ),
        ),
      ),
    );
  }

  // showToDoDetailPage() {
  //   Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
  //     return new ToDoDetailPage(todo);
  //   }));
  // }
}
