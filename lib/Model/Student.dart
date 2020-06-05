class Student{

  int studentID;
  String name;
  String email;
  int age;
  String phoneNumber;


  Student({this.studentID, this.name, this.email, this.age, this.phoneNumber});


  Map<String, dynamic> toJson(){
    return {
      "studentID" : studentID,
      "name" : name,
      "email" : email,
      "age" : age,
      "phoneNumber" : phoneNumber
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentID: json['studentID'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      phoneNumber: json['phoneNumber'],
    );
  }

}