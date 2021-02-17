import 'package:appointment/models/entities/Pacient.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBController {



  Future<Database> getDB() async {
    Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'appointment_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE patients(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, phoneNumber TEXT, extra TEXT)"
        );
      },

      version: 2,
    );

    return database;
  }

  Future<AlertDialog> insertPatient(Pacient pacient) async {
    Database db = await getDB();
    await db.insert(
        'patients', pacient.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );

    return AlertDialog(title: Text('Success Message'), content: Text("Success"));
  }

  Future<List<Pacient>> pacients() async {
    // Get a reference to the database.
    final Database db = await getDB();

    // Query the table for all The pacients.
    final List<Map<String, dynamic>> maps = await db.query('patients');

    // Convert the List<Map<String, dynamic> into a List<Pacient>.
    return List.generate(maps.length, (i) {
      return Pacient(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        phoneNumber: maps[i]['phoneNumber'],
        extra: maps[i]['extra'],
      );
    });
  }

  Future<void> deletePacient(int id) async {
    final db = await getDB();

    await db.delete(
        'pacients', where: "id = ?", whereArgs: [id]

    );
  }

  Future<void> updatePacient(Pacient pacient) async {
    final db = await getDB();

    await db.update('pacients', pacient.toMap(),
    where: "id = ?", whereArgs: [pacient.id]);
  }
}