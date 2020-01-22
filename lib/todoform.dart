import 'package:flutter/material.dart';
import 'package:flutterAssessment/todomodel.dart';
import 'package:flutterAssessment/utils.dart';
import 'package:flutterAssessment/customui.dart';

class AddToDoFormPage extends StatefulWidget {
  final ToDo todo;
  AddToDoFormPage([this.todo]);

  @override
  _AddToDoFormPageState createState() => new _AddToDoFormPageState();
}

class _AddToDoFormPageState extends State<AddToDoFormPage> {
  TextEditingController titleController = new TextEditingController();
  TextEditingController startdateController = new TextEditingController();
  TextEditingController enddateController = new TextEditingController();

  void initState() {
    if(widget.todo != null){
      titleController.text = widget.todo.title;
      startdateController.text = widget.todo.startdate;
      enddateController.text = widget.todo.enddate;
    }
    super.initState();
  }

  void submitNewToDo(context) {
    var error = "";

    if (titleController.text.isEmpty)
      error = "Title";
    else if(startdateController.text.isEmpty)
      error = "Start Date";
    else if(enddateController.text.isEmpty)
      error = "End Date";

    if(!error.isEmpty){
      alert(context, "Error", error + " field is required!");
      return;
    }

    if(DateTime.parse(enddateController.text).difference(DateTime.parse(startdateController.text)).inHours < 0){
      alert(context, "Error", "Start date cannot be late than End date");
      return;
    }

    if(widget.todo != null){
      widget.todo.title = titleController.text;
      widget.todo.startdate = startdateController.text;
      widget.todo.enddate = enddateController.text;
      Navigator.of(context).pop();
      return;
    }

    var newToDo = new ToDo(titleController.text, startdateController.text,
        enddateController.text, false, "");
    Navigator.of(context).pop(newToDo);
    
  }

  Widget get bottomBanner {
    String buttonLabel = widget.todo != null ? "Save Change" : "Create Now";
    return new BottomAppBar(
      child: new GestureDetector(
        onTap: (){
          submitNewToDo(context);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.06,
          color: Colors.black,
          child: new Center(child:new Text(
            buttonLabel,
            style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget get TitleInput {
    return new Padding(
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
    );
  }

  Widget CustomDateInput(label, controller){
    return new Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: new Column(
          children: [
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(label),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: dateInputField(context, controller)
            ),
          ],
      ),
    );
  }

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
              TitleInput,
              CustomDateInput("Start Date", startdateController),
              CustomDateInput("Estimated End Date", enddateController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomBanner
    );
  }
}
