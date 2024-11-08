import 'package:flutter/material.dart';
import 'package:student_info/add_student.dart';
import 'package:student_info/view_students.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  //final const sz = MediaQuery.sizeof(context).height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ClipOval(
                  child: Image.asset("assets/images/agenda32.png",),
                ),
              ),
              
              SizedBox(height: 100),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddStudent()));
              },
              child: const Text("Add Student",
              style: 
                TextStyle(color: Colors.black),
              ),
              ),

              SizedBox(height: 20),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewStudents()));
              },
              child: const Text("View All Students",
              style: 
                TextStyle(color: Colors.black),
              ),
              )
            ],
            ),
        ),
    );

  }
}