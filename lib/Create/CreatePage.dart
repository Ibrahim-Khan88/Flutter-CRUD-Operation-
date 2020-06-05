import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectdemo/Model/Student.dart';
import 'dart:io';
import 'package:projectdemo/Service/StudentService.dart';
//import 'package:image_picker/image_picker.dart';

class StudentCreate extends StatefulWidget {
  final Student student;

  StudentCreate({this.student});

  @override
  State<StatefulWidget> createState() {
    return _StudentCreateState(this.student);
  }
}

class _StudentCreateState extends State<StudentCreate> {
  _StudentCreateState(this.student);

  int studentId;
  final Student student;
  var _formkey = GlobalKey<FormState>();

  bool get isEditting => student != null;
  bool createResult = false;
  Future<File> imageFile;
  File tmpFile;
  String base64Image;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  final studentService = new StudentService();

  @override
  void initState() {
    if (isEditting) {
      studentId = student.studentID;
      _nameController.text = student.name;
      _ageController.text = "${student.age}";
      _emailController.text = student.email;
      _phoneController.text = student.phoneNumber;
    }
    super.initState();
  }

  bool checkCreate(Student student) {
    studentService.createStudent(student).then((value) {
      debugPrint("value is $value");
      return value;
    });
    // return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isEditting ? "Modify Information" : "Add New Student"),
        ),
        body: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Student Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                Container(
                  height: 12,
                ),

                TextFormField(
                  controller: _emailController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Student Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                Container(
                  height: 12,
                ),
                TextFormField(
                  controller: _ageController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter age";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Student Age",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                Container(
                  height: 12,
                ),
                TextFormField(
                  controller: _phoneController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Student Phone Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                Container(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: RaisedButton(
                    child: Text(
                      isEditting? "Update " : "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {

                      if(_formkey.currentState.validate()) {
                        if (isEditting) {
                          final student = Student(
                              name: _nameController.text,
                              email: _emailController.text,
                              age: int.parse(_ageController.text),
                              phoneNumber: _phoneController.text);

                          String text = "";
                          final result = await studentService
                              .updateStudent(student, studentId)
                              .then((value) {

                            text = value
                                ? "Successfully Updated"
                                : "An error is occurred";
                          });

                          showDialog(
                              context: context,
                              builder: (_) =>
                                  AlertDialog(
                                    title: Text("Done"),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          debugPrint("pressed");
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          //debugPrint("pressed 1");
                                        },
                                      )
                                    ],
                                  ));
                        }
                        else {
                          final student = Student(
                              name: _nameController.text,
                              email: _emailController.text,
                              age: int.parse(_ageController.text),
                              phoneNumber: _phoneController.text);

                          String text = "";
                          final result = await studentService
                              .createStudent(student)
                              .then((value) {

                            text = value
                                ? "Successfully created"
                                : "An error is occurred";

                          });


                          showDialog(
                              context: context,
                              builder: (_) =>
                                  AlertDialog(
                                    title: Text("Done"),
                                    content: Text(text),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: () {
                                          debugPrint("pressed");
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          //debugPrint("pressed 1");
                                        },
                                      )
                                    ],
                                  ));
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
