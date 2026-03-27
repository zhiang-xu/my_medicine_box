import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // 数据库名称
  static const String _databaseName = 'medicine_box.db';
  static const int _databaseVersion = 1;

  // 表名
  static const String tableMedicine = 'medicine';
  static const String tableUser = 'user';
  static const String tableMedicineImage = 'medicine_image';

  // 获取数据库实例
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // 初始化数据库
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // 创建表
  Future<void> _onCreate(Database db, int version) async {
    // 创建药品表
    await db.execute('''
      CREATE TABLE $tableMedicine (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        brand TEXT NOT NULL,
        category TEXT NOT NULL,
        totalQuantity TEXT NOT NULL,
        remainingQuantity TEXT NOT NULL,
        price REAL NOT NULL,
        purchaseMethod TEXT NOT NULL,
        purchaseChannel TEXT NOT NULL,
        purchaseAddress TEXT NOT NULL,
        purchaseDate TEXT NOT NULL,
        expiryDate TEXT NOT NULL,
        userId INTEGER NOT NULL,
        status INTEGER NOT NULL,
        remarks TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // 创建用户表
    await db.execute('''
      CREATE TABLE $tableUser (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT
      )
    ''');

    // 创建药品图片表
    await db.execute('''
      CREATE TABLE $tableMedicineImage (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medicineId INTEGER NOT NULL,
        imagePath TEXT NOT NULL,
        type INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (medicineId) REFERENCES $tableMedicine (id) ON DELETE CASCADE
      )
    ''');

    // 创建索引
    await db.execute('''
      CREATE INDEX idx_medicine_expiry ON $tableMedicine(expiryDate)
    ''');

    await db.execute('''
      CREATE INDEX idx_medicine_user ON $tableMedicine(userId)
    ''');

    await db.execute('''
      CREATE INDEX idx_image_medicine ON $tableMedicineImage(medicineId)
    ''');

    // 插入默认管理员用户
    await db.insert(
      tableUser,
      {
        'name': '管理员',
        'role': 'admin',
        'createdAt': DateTime.now().toIso8601String(),
      },
    );
  }

  // 升级数据库
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 未来版本升级逻辑
  }

  // 关闭数据库
  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  // 清空所有数据（用于测试）
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(tableMedicineImage);
    await db.delete(tableMedicine);
    await db.delete(tableUser);
  }
}
