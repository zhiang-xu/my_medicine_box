import 'package:flutter/foundation.dart';
import '../models/medicine.dart';
import '../database/medicine_dao.dart';

class MedicineProvider with ChangeNotifier {
  final MedicineDao _medicineDao = MedicineDao();

  List<Medicine> _medicines = [];
  List<Medicine> _searchResults = [];
  Map<String, int> _statistics = {};
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Medicine> get medicines => _medicines;
  List<Medicine> get searchResults => _searchResults;
  Map<String, int> get statistics => _statistics;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // 加载所有药品
  Future<void> loadMedicines() async {
    _setLoading(true);
    try {
      _medicines = await _medicineDao.getAll();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('加载药品失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  // 加载统计数据
  Future<void> loadStatistics() async {
    try {
      _statistics = await _medicineDao.getStatistics();
      notifyListeners();
    } catch (e) {
      debugPrint('加载统计失败: $e');
    }
  }

  // 添加药品
  Future<bool> addMedicine(Medicine medicine) async {
    _setLoading(true);
    try {
      await _medicineDao.insert(medicine);
      await loadMedicines();
      await loadStatistics();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('添加药品失败: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 更新药品
  Future<bool> updateMedicine(Medicine medicine) async {
    _setLoading(true);
    try {
      await _medicineDao.update(medicine);
      await loadMedicines();
      await loadStatistics();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('更新药品失败: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 删除药品
  Future<bool> deleteMedicine(int id) async {
    _setLoading(true);
    try {
      await _medicineDao.delete(id);
      await loadMedicines();
      await loadStatistics();
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('删除药品失败: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 搜索药品
  Future<void> searchMedicine(String keyword) async {
    if (keyword.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _setLoading(true);
    try {
      _searchResults = await _medicineDao.search(keyword);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('搜索药品失败: $e');
    } finally {
      _setLoading(false);
    }
  }

  // 获取即将过期的药品
  Future<List<Medicine>> getExpiringSoon() async {
    try {
      return await _medicineDao.getExpiringSoon();
    } catch (e) {
      debugPrint('获取即将过期药品失败: $e');
      return [];
    }
  }

  // 获取已过期的药品
  Future<List<Medicine>> getExpired() async {
    try {
      return await _medicineDao.getExpired();
    } catch (e) {
      debugPrint('获取过期药品失败: $e');
      return [];
    }
  }

  // 更新过期状态
  Future<void> updateExpiredStatus() async {
    try {
      await _medicineDao.updateExpiredStatus();
      await loadMedicines();
      await loadStatistics();
    } catch (e) {
      debugPrint('更新过期状态失败: $e');
    }
  }

  // 清除错误
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // 设置加载状态
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
