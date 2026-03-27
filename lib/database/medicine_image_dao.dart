import '../models/medicine_image.dart';
import 'database_helper.dart';

class MedicineImageDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // 插入图片
  Future<int> insert(MedicineImage image) async {
    final db = await _dbHelper.database;
    return await db.insert(
      DatabaseHelper.tableMedicineImage,
      image.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 删除图片
  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseHelper.tableMedicineImage,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 根据药品ID查询所有图片
  Future<List<MedicineImage>> getByMedicineId(int medicineId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicineImage,
      where: 'medicineId = ?',
      whereArgs: [medicineId],
      orderBy: 'type ASC, createdAt ASC',
    );

    return maps.map((map) => MedicineImage.fromMap(map)).toList();
  }

  // 根据药品ID和类型查询图片
  Future<MedicineImage?> getByMedicineIdAndType(
    int medicineId,
    ImageType type,
  ) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableMedicineImage,
      where: 'medicineId = ? AND type = ?',
      whereArgs: [medicineId, type.index],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return MedicineImage.fromMap(maps.first);
  }

  // 删除药品的所有图片
  Future<int> deleteByMedicineId(int medicineId) async {
    final db = await _dbHelper.database;
    return await db.delete(
      DatabaseHelper.tableMedicineImage,
      where: 'medicineId = ?',
      whereArgs: [medicineId],
    );
  }
}
