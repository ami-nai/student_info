import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_info/database/db_helper.dart';
import 'package:student_info/model/s_info.dart';
import 'package:student_info/view_students.dart';

class UpdateInfo extends StatefulWidget {
  final sinfo;
  const UpdateInfo({super.key, required this.sinfo});

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {

  late DbHelper dbHelper;

  TextEditingController s_name_controller = TextEditingController();
  TextEditingController s_id_controller = TextEditingController();
  TextEditingController s_phone_controller = TextEditingController();
  TextEditingController s_email_controller = TextEditingController();
  TextEditingController s_location_controller = TextEditingController();

  final GlobalKey<FormState> infoFormKey = GlobalKey();

  int? id;

  //add notes to database
  Future  UpdateInfo(int id) async
  {
    final updateInfo = SInfo(
      sid: s_id_controller.text,
      sname: s_name_controller.text,
      sphone: s_phone_controller.text,
      semail: s_email_controller.text,
      slocation: s_location_controller.text,
    );

    int check= await dbHelper.updateData(updateInfo.toMap(),id);
    print("Check=$check");
    if(check>0)
    {

      Get.snackbar("Updated", "Info Updated",snackPosition: SnackPosition.BOTTOM);
      Get.offAll(ViewStudents());

    }
    else
    {
      Get.snackbar("Error", "Error in updating info",snackPosition: SnackPosition.BOTTOM);
    }


  }

  @override
  void initState() {
    //TODO: Implement initState
    super.initState();
    dbHelper = DbHelper.instance;

    id = widget.sinfo.id;
    s_id_controller.text = widget.sinfo.sid;
    s_name_controller.text = widget.sinfo.sname;
    s_phone_controller.text = widget.sinfo.sphone;
    s_email_controller.text = widget.sinfo.semail;
    s_location_controller.text = widget.sinfo.slocation;
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      }

                      return null;
                    },
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Id";
                      }

                      return null;
                    },
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter phone number";
                      }

                      return null;
                    },
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }

                      return null;
                    },
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter location";
                      }

                      return null;
                    },
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
                      UpdateInfo(id!);
                    }
                    
                  }
                },
                  child: Text("Update Info"),
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