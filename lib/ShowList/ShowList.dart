import 'package:flutter/material.dart';
import 'package:projectdemo/Create/CreatePage.dart';
import 'package:projectdemo/Model/Student.dart';
import 'package:projectdemo/Service/StudentService.dart';
import 'package:projectdemo/ShowList/DeleteAlert.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentListState();
  }
}

class _StudentListState extends State<StudentList> {
  var service = StudentService();
  bool isLodding = false;

  @override
  void initState() {
    super.initState();
  }

  _deleteFunction(BuildContext context, int studentID) async {

    final result =
        await showDialog(context: context, builder: (_) => DeleteAlert());

    if (result) {
      final deleteresult = await service.deleteStudent(studentID);
      var message;
      if (deleteresult != null && deleteresult == true) {
        message = "The student records is deleted successfully";
      } else {
        message = "An error is occurred";
      }

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      setState(() {

                      });
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List of Student"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => StudentCreate()))
                .then((value) {
              setState(() {});
            });
          },
          child: Icon(Icons.add),
        ),
        body: Center(
          child: FutureBuilder(
            future: service.getStudentList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Student> students = snapshot.data;

                return ListView.separated(
                    separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: Colors.green,
                        ),
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.account_circle),
                        ),
                        title: Text(
                          students[index].name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor),
                        ),
                        subtitle: Text(students[index].email),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: (_) => StudentCreate(
                                  student: students[index])))
                              .then((value) {
                            setState(() {});
                          });
                        },
                        trailing: GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.deepPurple,
                          ),
                          onTap: () {
                            _deleteFunction(
                                context, students[index].studentID);
                          },
                        ),
                      );
                    },
                    itemCount: students.length);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return new CircularProgressIndicator();
            },
          ),
        ));
  }
}
