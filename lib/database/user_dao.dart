import '../models/user.dart';
import 'database_helper.dart';

class UserDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // 插入用户
  Future<int> insert(User user) async {
    final db = await _dbHelper.database;
    return await db.insert(
      DatabaseHelper.tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 更新用户
  Future<int> update(User user) async {
    final db = await _dbHelper.database;
    return await db.update(
      DatabaseHelper.tableUser,
      user.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // 删除用户
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseHelper.tableUser,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 根据ID查询用户
  Future<User?> getById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableUser,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return User.fromMap(maps.first);
  }

  // 查询所有用户
  Future<List<User>> getAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableUser,
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => User.fromMap(map)).toList();
  }

  // 根据角色查询用户
  Future<List<User>> getByRole(String role) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableUser,
      where: 'role = ?',
      whereArgs: [role],
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => User.fromMap(map)).toList();
  }
}
