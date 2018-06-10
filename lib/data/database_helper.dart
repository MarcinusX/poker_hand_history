import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poker_hand_history/model/hand.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Hand(id integer primary key autoincrement, json TEXT)");
    print("Table is created");
  }

//insertion
  Future<int> saveHand(Hand hand) async {
    var dbClient = await db;
    int res = await dbClient.insert("Hand", {
      'json': json.encode(hand.toMap()),
    });
    return res;
  }

  Future<List<Hand>> getAllHands() async {
    var dbClient = await db;
    return (await dbClient.query(
      "Hand",
      columns: ["id", "json"],
    ))
        .map((map) => new Hand.fromMap(json.decode(map["json"])))
        .toList();
  }

  Future<int> deleteAllHands() async {
    return (await db).delete("Hand");
  }
}
