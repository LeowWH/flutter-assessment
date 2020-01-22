import 'package:flutter/material.dart';
import 'package:flutterAssessment/todomodel.dart';
import 'package:flutterAssessment/utils.dart';
import 'package:flutterAssessment/customui.dart';

class AddToDoFormPage extends StatefulWidget {
  @override
  _AddToDoFormPageState createState() => new _AddToDoFormPageState();
}

class _AddToDoFormPageState extends State<AddToDoFormPage> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController startdateController = new TextEditingController();
  TextEditingController enddateController = new TextEditingController();



  void submitNewToDo(context) {
    var missing = "";

    if (titleController.text.isEmpty)
      missing = "Title";
    else if(startdateController.text.isEmpty)
      missing = "Start Date";
    else if(enddateController.text.isEmpty)
      missing = "End Date";

    if(!missing.isEmpty){
      alert(context, "Error", missing + " field is required!");
    }else{
      var newToDo = new ToDo(titleController.text, startdateController.text,
          enddateController.text, false, "");
      Navigator.of(context).pop(newToDo);
    }
  }

  Widget bottomBanner = new Container (
    padding: new EdgeInsets.all(8.0),
    color: new Color(0X99CC0000),
    height: 48.0,
    child: new Center(
      child: new Text('Bottom Banner'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: new Text('Add a new ToDo',style: TextStyle(color: Colors.black),),
        ),
        backgroundColor: Color.fromRGBO(253, 177, 0, 1),
      ),
      body: new Container(
        color: Colors.white,
        child: new Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 32.0,
          ),
          child: new Column(
            children: [
              new Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: new Column(
                    children: [
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Title"),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: new TextField(
                          controller: titleController,
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
                            hintText: 'Please key in your To-Do title here',
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        ),
                      ),
                    ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: new Column(
                    children: [
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Start Date"),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: dateInputField(context, startdateController)
                      ),
                    ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: new Column(
                    children: [
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("Estimated End Date"),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: dateInputField(context, enddateController)
                      ),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new GestureDetector(
          onTap: (){
            submitNewToDo(context);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            color: Colors.black,
            child: new Center(child:new Text(
              'Create Now',
              style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
