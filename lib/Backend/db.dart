import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ImageDatabaseHelper {
  static final ImageDatabaseHelper _instance = ImageDatabaseHelper._internal();

  factory ImageDatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();

    return _db!;
  }

  ImageDatabaseHelper._internal();

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'image_database.db');

    // Delete the old database to avoid conflicts.
    await deleteDatabase(path);

    // Create the new database.
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE image_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        image_path TEXT,
        date_added TEXT
      )
    ''');
  }

  Future<int> addImageData(File imageFile) async {
    final imageData = ImageData(
      imagePath: imageFile.path,
      dateAdded: DateTime.now().toString(),
    );

    final dbClient = await db;
    final id = await dbClient.insert('image_data', imageData.toMap());

    return id;
  }

  Future<List<ImageData>> getImageDataList() async {
    final dbClient = await db;
    final result = await dbClient.query('image_data');

    final imageDataList = result.map((row) {
      return ImageData.fromMap(row);
    }).toList();

    return imageDataList;
  }
}

class ImageData {
  int? id;
  String imagePath;
  String dateAdded;

  ImageData({this.id, required this.imagePath,required this.dateAdded});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'image_path': imagePath,
      'date_added': dateAdded,
    };

    if (id != null) {
      map['id'] = id;
    }
  
    return map;
  }

  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      id: map['id'],
      imagePath: map['image_path'],
      dateAdded: map['date_added'],
    );
  }
}
