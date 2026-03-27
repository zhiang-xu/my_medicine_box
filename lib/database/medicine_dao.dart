import '../models/medicine.dart';
import 'database_helper.dart';

class MedicineDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // 插入药品
  Future<int> insert(Medicine medicine) async {
    final db = await _dbHelper.database;
    return await db.insert(
      DatabaseHelper.tableMedicine,
      medicine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 更新药品
  Future<int> update(Medicine medicine) async {
    final db = await _dbHelper.database;
    return await db.update(
      DatabaseHelper.tableMedicine,
      medicine.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [medicine.id],
    );
  }

  // 删除药品
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseHelper.tableMedicine,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 根据ID查询药品
  Future<Medicine?> getById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicine,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return Medicine.fromMap(maps.first);
  }

  // 查询所有药品
  Future<List<Medicine>> getAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicine,
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => Medicine.fromMap(map)).toList();
  }

  // 根据用户ID查询药品
  Future<List<Medicine>> getByUserId(int userId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicine,
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => Medicine.fromMap(map)).toList();
  }

  // 搜索药品（根据名称、品牌、分类）
  Future<List<Medicine>> search(String keyword) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicine,
      where: 'name LIKE ? OR brand LIKE ? OR category LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%', '%$keyword%'],
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => Medicine.fromMap(map)).toList();
  }

  // 获取已过期的药品
  Future<List<Medicine>> getExpired() async {
    final db = await _dbHelper.database;
    final now = DateTime.now().toIso8601String();
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicine,
      where: 'expiryDate < ? AND status = ?',
      whereArgs: [now, MedicineStatus.normal.index],
      orderBy: 'expiryDate ASC',
    );

    return maps.map((map) => Medicine.fromMap(map)).toList();
  }

  // 获取即将过期的药品（30天内）
  Future<List<Medicine>> getExpiringSoon() async {
    final db = await _dbHelper.database;
    final now = DateTime.now();
    final thirtyDaysLater = now.add(const Duration(days: 30));

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicine,
      where: 'expiryDate > ? AND expiryDate < ? AND status = ?',
      whereArgs: [
        now.toIso8601String(),
        thirtyDaysLater.toIso8601String(),
        MedicineStatus.normal.index,
      ],
      orderBy: 'expiryDate ASC',
    );

    return maps.map((map) => Medicine.fromMap(map)).toList();
  }

  // 获取正常状态的药品
  Future<List<Medicine>> getNormal() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicine,
      where: 'status = ?',
      whereArgs: [MedicineStatus.normal.index],
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) => Medicine.fromMap(map)).toList();
  }

  // 获取统计数据
  Future<Map<String, int>> getStatistics() async {
    final expired = await getExpired();
    final expiringSoon = await getExpiringSoon();
    final all = await getAll();
    final normal = all.where((m) => m.status == MedicineStatus.normal).length;

    return {
      'total': normal,
      'expired': expired.length,
      'expiringSoon': expiringSoon.length,
    };
  }

  // 获取总费用
  Future<double> getTotalPrice() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery(
      'SELECT SUM(price) as total FROM ${DatabaseHelper.tableMedicine}',
    );

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  // 批量更新过期状态
  Future<int> updateExpiredStatus() async {
    final db = await _dbHelper.database;
    final now = DateTime.now().toIso8601String();

    return await db.update(
      DatabaseHelper.tableMedicine,
      {'status': MedicineStatus.expired.index},
      where: 'expiryDate < ? AND status = ?',
      whereArgs: [now, MedicineStatus.normal.index],
    );
  }
}
