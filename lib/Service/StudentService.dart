import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectdemo/Model/Student.dart';

class StudentService{

  static final API = 'http://10.0.2.2:8080/student';
  static final headers = {
    "Content-Type" : "application/json"
  };


  Future<List<Student>>  getStudentList(){
    final students = <Student>[];
    return http.get(API).then((data){
      if(data.statusCode == 200) {
        List jsonData = json.decode(data.body);

        for (var item in jsonData) {
          final student = Student.fromJson(item);
          students.add(student);
        }
      }
      return students;
    });
  }


  Future<bool> createStudent(Student student){

    return http.post(API,headers: headers, body: json.encode(student.toJson())).then((data) {

      if(data.statusCode == 200){
        return true;
      }
      else{
        return false;
      }

    }).catchError((error){ print(error);});

  }


  Future<bool> updateStudent(Student student, int studentID){


    return http.put(API+"/$studentID",headers: headers, body: json.encode(student.toJson())).then((data) {

      if(data.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }).catchError((error){ print(error);});
  }

  Future<bool> deleteStudent(int studentID){

    return http.delete(API+"/$studentID",headers: headers).then((data) {

      if(data.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }).catchError((error){ print(error);});
  }


}

