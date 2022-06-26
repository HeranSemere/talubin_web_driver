
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/*
createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'my.db');

  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
  return database;
}

void populateDb(Database database, int version) async {
  await database.execute("CREATE TABLE Customer ("
          "id INTEGER PRIMARY KEY,"
          "first_name TEXT,"
          "last_name TEXT,"
          "email TEXT"
          ")");
}

Future<int> createCustomer(Customer customer) async {
  var result = await database.insert("Customer", customer.toMap());
  return result;
}

createCustomer2(Customer customer) async {
    var result = await database.rawInsert(
      "INSERT INTO Customer (id,first_name, last_name, email)"
      " VALUES (${customer.id},${customer.firstName},${customer.lastName},${customer.email})");
    return result;
  }

Future<List> getCustomers() async {
  var result = await database.query("Customer", columns: ["id", "first_name", "last_name", "email"]);

  return result.toList();
}


Future<List> getCustomers2() async {
  var result = await database.rawQuery('SELECT * FROM Customer');
  return result.toList();
}


Future<Customer> getCustomer(int id) async {
  List<Map> results = await db.query("Customer",
      columns: ["id", "first_name", "last_name", "email"],
      where: 'id = ?',
      whereArgs: [id]);

  if (results.length > 0) {
    return new Customer.fromMap(results.first);
  }

  return null;
}

Future<Customer> getCustomer2(int id) async {
  var results = await database.rawQuery('SELECT * FROM Customer WHERE id = $id');

  if (results.length > 0) {
    return new Customer.fromMap(results.first);
  }

  return null;
}

*/