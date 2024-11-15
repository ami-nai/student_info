//model class
class SInfo {
  int? id;
  String? sname;
  String? sid;
  String? sphone;
  String? semail;
  String? slocation;

  //constructor
  SInfo({
    this.id,
    this.sname,
    this.sid,
    this.sphone,
    this.semail,
    this.slocation
  });

  //for saving data to db
  //name must be same as table in db
  Map<String, dynamic> toMap(){
    return{
      "s_id": sid,
      "s_name": sname,
      "s_phone": sphone,
      "s_email": semail,
      "s_location": slocation,
    };
  }

  //for retrieving data from db
  static SInfo fromMap(Map<String, dynamic> map){
    return SInfo(
      id: map['id'],
      sname: map['s_name'],
      sid: map['s_id'],
      sphone: map['s_phone'],
      semail: map['s_email'],
      slocation: map['s_location']
    );
  }

}