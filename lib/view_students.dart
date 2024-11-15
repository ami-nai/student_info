import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_info/database/db_helper.dart';
import 'package:student_info/model/s_info.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  
  late DbHelper dbHelper;
  List <SInfo> sinfo = [];
  
  @override

  void initState(){
    super.initState();

    //initializing dbHelper
    dbHelper = DbHelper.instance;

    //load all info
    loadAllInfo();
  }

  //for loding all data from db
  Future loadAllInfo() async {
    final data = await dbHelper.getAllData();
    print("Data loaded from DB: $data");

    setState((){
      sinfo = data.map((e) => SInfo.fromMap(e)).toList();
  });
  }

  //for deleting node
  Future deleteInfo(int s_id) async {
    int check = await dbHelper.deleteData(s_id);
    if(check > 0){
      Fluttertoast.showToast(
        msg: "Info deleted successfully",
      );
    }
    else{
      Get.defaultDialog(
        title: "Failed to delete info",
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students Information"),
        backgroundColor: Colors.blue,
      ),
      body:
        sinfo.isEmpty
        ? const Center(child: Text("No student info available"),)
        :ListView.builder(
          itemCount: sinfo.length,
          itemBuilder: (context, index){
            SInfo info = sinfo[index];
            return Padding(padding: const EdgeInsets.all(10.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.blue, width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(info.sname!, style: 
                  TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Id: ${info.sid!}", style: 
                  TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("Phone: ${info.sphone!}"),
                  Text("Email: ${info.semail!}"),
                  Text("Location: ${info.slocation!}"),
                ],
              ),
            ),
            );
          }
        )
    );
  }
}