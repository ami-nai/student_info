import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:student_info/database/db_helper.dart';
import 'package:student_info/model/s_info.dart';
import 'package:student_info/view_students.dart';




class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {


  late DbHelper dbHelper;

  TextEditingController s_name_controller = TextEditingController();
  TextEditingController s_id_controller = TextEditingController();
  TextEditingController s_phone_controller = TextEditingController();
  TextEditingController s_email_controller = TextEditingController();
  TextEditingController s_location_controller = TextEditingController();

  final GlobalKey<FormState> infoFormKey = GlobalKey();

  //add notes to database
  Future addInfo() async
  {
    final newInfo = SInfo(
      sid: s_id_controller.text,
      sname: s_name_controller.text,
      sphone: s_phone_controller.text,
      semail: s_email_controller.text,
      slocation: s_location_controller.text,
    );

    //if data insert successfully, its return row number which is greater that 1 always
    int check= await dbHelper.insertData(newInfo.toMap());
    print("Check=$check");

    if(check>0)
      {
        Get.snackbar("Success", "Info Added",snackPosition: SnackPosition.BOTTOM);
        Get.offAll(() => ViewStudents());
      }
    else
      {
        Get.snackbar("Error", "Error in adding info",snackPosition: SnackPosition.BOTTOM);
      }


  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper.instance;

  }

  @override

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      
      body: Form(
            key: infoFormKey,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
        
                SizedBox(
                  height: size.height * 0.065,
                  width: size.width * 0.7,
                  child: TextFormField(
                    controller: s_name_controller,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Name",
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  height: size.height * 0.065,
                  width: size.width * 0.7,
                  child: TextFormField(
                    controller: s_id_controller,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Id",
                      prefixIcon: const Icon(Icons.perm_identity),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  height: size.height * 0.065,
                  width: size.width * 0.7,
                  child: TextFormField(
                    controller: s_phone_controller,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Phone",
                      prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  height: size.height * 0.065,
                  width: size.width * 0.7,
                  child: TextFormField(
                    controller: s_email_controller,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                  height: size.height * 0.065,
                  width: size.width * 0.7,
                  child: TextFormField(
                    controller: s_location_controller,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Location",
                      prefixIcon: const Icon(Icons.location_city),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
        
                ElevatedButton(onPressed: (){
                  String email = s_email_controller.text;
                  if(!email.contains("@") || !email.contains(".")){
                    print("Invalid email");
                    Get.snackbar(
                      "Invalid email",
                      "Please enter a valid email",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      );
                  }
                  else{
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => const ViewStudents()),
                    // );
                    if(infoFormKey.currentState!.validate()){
                      infoFormKey.currentState!.save();
                      addInfo();
                    }
                    
                  }
                },
                  child: Text("Submit"),
                  ),
        
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}







