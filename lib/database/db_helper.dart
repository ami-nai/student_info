import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  //database name
  static const databaseName = "students_info.db";

  //database version
  static const databaseVersion = 1;

  //table name
  static const tableName = "info";

  //column name
  static const columnId = "id";
  static const columnSName = "s_name";
  static const columnSId = "s_id";
  static const columnSPhone = "s_phone";
  static const columnSEmail = "s_email";
  static const columnSLocation = "s_location";

  //create a single instanc of DbHelper
  DbHelper.privateConstructor();
  static final DbHelper instance = DbHelper.privateConstructor();

  static Database? myDb;

  //for initializing database
  Future<Database?> get database async{
    if(myDb != null) return myDb;
    myDb = await initDatabase();
    return myDb;
  }

  //for initializing the database path
  initDatabase() async{
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: createTables,
    );
  }
  
  //for creating table in database if not exist already
  Future createTables(Database db, int version) async{
    await db.execute(
      """
      CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnSName TEXT NOT NULL,
      $columnSId TEXT NOT NULL,
      $columnSPhone TEXT NOT NULL,
      $columnSEmail TEXT NOT NULL,
      $columnSLocation TEXT NOT NULL
      )
      """
    );
  }

  //for insert data
  Future<int> insertData(Map<String, dynamic> row) async{
    Database? db = await instance.database;
    //return await db!.insert(tableName, row);
    int id = await db!.insert(tableName, row);
    print("Inserted data with ID: $id"); // Check if data is inserted
    return id;
  }

  //for read data from database
  Future<List<Map<String, dynamic>>> getAllData() async {
    Database? db = await instance.database;

    return await db!.query(tableName, orderBy: "$columnId DESC");

    // Use rawQuery to select all notes
   // List<Map<String, dynamic>> notes = await db!.rawQuery('SELECT * FROM notes');

    //return notes;
  }

  //for update data in database
  Future<int> updateData(Map<String, dynamic> row,int id) async {
    Database? db = await instance.database;

    return await db!
        .update(tableName, row, where: '$columnId = ?', whereArgs: [id]);

    // await db.rawQuery(
    //     'SELECT * FROM notes WHERE userId = ?',
    //     [userId]);

  }

  //for delete data from database
  Future<int> deleteData(int id) async {
    Database? db = await instance.database;
    return await db!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

}