import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:talu_bin_driver/apps/models/completed_task.dart';
import 'package:talu_bin_driver/apps/models/completed_task_local.dart';


class CompletedTasksDatabase {

  Future<Database> createDB() async {

    final database = openDatabase(

      join(await getDatabasesPath(), 'completed_tasks_database.db'),

      onCreate: (db, version) {
        return db.execute(
          //'CREATE TABLE completed_tasks(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
          'CREATE TABLE completed_tasks(completedDate TEXT PRIMARY KEY, userId TEXT, institutionName TEXT, TBNumber TEXT, weightBlue INTEGER, weightRed INTEGER, weightOther INTEGER, long REAL, lat REAL, institutionId TEXT, createdDate TEXT, updatedDate TEXT, completedId TEXT)',
        );
      },
      version: 1,
    );

    return database;
/*
    openDatabase(
      join(await getDatabasesPath(), 'completed_tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
          //'CREATE TABLE completed_tasks(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
          'CREATE TABLE completed_tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, completedDate TEXT, userId TEXT, institutionName TEXT, TBNumber TEXT, weightBlue REAL, weightRed REAL, weightOther REAL, long REAL, lat REAL, institutionId TEXT, createdDate TEXT, updatedDate TEXT, completedId TEXT )',
        );
      },
      version: 1,).then((value){


            db = value;


        }).catchError((Exception){


          print("couldn't open/create database");

        });
*/
    
  }

  
  Future<void> insertCompletedTask(List<CompletedTask> cts, Database db) async {
    
    /*
      var data ={
      'completedDate': "10/10/2021",
      'userId': "dfsgsdf",
      'institutionName': "My Institution",
      'TBNumber': "MI10",
      'weightBlue': 35,
      'weightRed': 36,
      'weightOther': 34,
      'long': 38,
      'lat': 9,
      'institutionId': "hfdskjfsdhjfhds",
      'createdDate': "1/10/2021",
      'updatedDate': "10/10/2021",
      'completedId ': "fsdgaa", //primary key
      };

      var response = await db.insert(
        'completed_tasks',
        //ctl.toMap(), //do this manually
        data,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
*/
      for(CompletedTask ct in cts){

        //List lists = await db.rawQuery('select * from completed_tasks');

        var response = await db.insert(
        'completed_tasks',
        //ctl.toMap(), //do this manually
        ct.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      print("Insert command response was: "+response.toString());
      }

     // await db.rawInsert('INSERT INTO my_table(name, age) VALUES(?, ?)', [name, age], );

      print("successfully added to local database");

      await db.close();

    }
  

  // A method that retrieves all the dogs from the dogs table.
  Future<List<CompletedTask>> getLocalCompletedTasks(Database db) async {

      print("In getcompleted tasks method");

      //await insertCompletedTask(CompletedTaskLocal(), db);

      List lists = await db.rawQuery('select * from completed_tasks');

      
      print(lists.length);

      await db.close();

      var completedtasks = List.generate(lists.length, (i) {
/*
        return CompletedTaskLocal(
          completedDate: lists[i]['completedDate'],
          userId: lists[i]['userId'],
          institutionName: lists[i]['institutionName'],
          tBNumber: lists[i]['TBNumber'],
          weightBlue: lists[i]['weightBlue'],
          weightRed: lists[i]['weightRed'],
          weightOther: lists[i]['weightOther'],
          long: lists[i]['long'],
          lat: lists[i]['lat'],
          institutionId: lists[i]['institutionId'],
          createdDate: lists[i]['createdDate'],
          updatedDate: lists[i]['updatedDate'],
          completedId: lists[i]['completedId'],
         
        );
*/

return CompletedTask(
          completedDate: lists[i]['completedDate'],
          userId: lists[i]['userId'],
          institutionName: lists[i]['institutionName'],
          tBNumber: lists[i]['TBNumber'],
          weight: Weight(blue:lists[i]['weightBlue'], red:lists[i]['weightRed'],other:lists[i]['weightOther'],),
          bin: Bin(location: Location(lat: lists[i]['lat'],long: lists[i]['long']),institutionId: lists[i]['institutionId'],createdDate: lists[i]['createdDate'],updatedDate: lists[i]['updatedDate'],id:lists[i]['completedId'])
         
        );
            /*
        weight!.blue: maps[i]['weightBlue'],
        weight!.red: maps[i]['weightRed'],
        weight!.other: maps[i]['weightOther'],
        bin!.location!.long: maps[i]['long'],
        bin!.location!.lat: maps[i]['lat'],
        bin!.institutionId : maps[i]['institutionId'],
        bin!.createdDate: maps[i]['createdDate'],
        bin!.updatedDate: maps[i]['updatedDate'],
        bin!.id: maps[i]['completedId'],*/

      

      });

      print("Inget completed tasks, length is"+completedtasks.length.toString());
      
      return completedtasks;
/*

 await createDB().then((value) async {
      final db = value;
      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('completed_tasks');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return CompletedTask(
          completedDate: maps[i]['completedDate'],
          userId: maps[i]['userId'],
          institutionName: maps[i]['institutionName'],
          tBNumber: maps[i]['TBNumber'],
          /*
        weight!.blue: maps[i]['weightBlue'],
        weight!.red: maps[i]['weightRed'],
        weight!.other: maps[i]['weightOther'],
        bin!.location!.long: maps[i]['long'],
        bin!.location!.lat: maps[i]['lat'],
        bin!.institutionId : maps[i]['institutionId'],
        bin!.createdDate: maps[i]['createdDate'],
        bin!.updatedDate: maps[i]['updatedDate'],
        bin!.id: maps[i]['completedId'],*/


        );
      }
      );



    }).catchError((onError) {


      Future.error("Couldn't get local completed tasks");

    });*/

  //  List<CompletedTask> a = [];

    //return lists;

  }

}