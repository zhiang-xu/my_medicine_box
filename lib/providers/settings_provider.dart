import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  SharedPreferences? _prefs;

  // 设置项
  bool _expiryNotificationEnabled = true;
  int _expiryNotificationDays = 30;
  String _expiryNotificationTime = '09:00';
  String _currentUserId = '1';

  // Getters
  bool get expiryNotificationEnabled => _expiryNotificationEnabled;
  int get expiryNotificationDays => _expiryNotificationDays;
  String get expiryNotificationTime => _expiryNotificationTime;
  String get currentUserId => _currentUserId;

  // 初始化设置
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSettings();
  }

  // 加载设置
  void _loadSettings() {
    if (_prefs != null) {
      _expiryNotificationEnabled =
          _prefs!.getBool('expiryNotificationEnabled') ?? true;
      _expiryNotificationDays =
          _prefs!.getInt('expiryNotificationDays') ?? 30;
      _expiryNotificationTime =
          _prefs!.getString('expiryNotificationTime') ?? '09:00';
      _currentUserId = _prefs!.getString('currentUserId') ?? '1';
    }
    notifyListeners();
  }

  // 保存设置
  Future<void> _saveSettings() async {
    if (_prefs != null) {
      await _prefs!.setBool('expiryNotificationEnabled', _expiryNotificationEnabled);
      await _prefs!.setInt('expiryNotificationDays', _expiryNotificationDays);
      await _prefs!.setString('expiryNotificationTime', _expiryNotificationTime);
      await _prefs!.setString('currentUserId', _currentUserId);
    }
  }

  // 设置过期提醒开关
  Future<void> setExpiryNotificationEnabled(bool enabled) async {
    _expiryNotificationEnabled = enabled;
    await _saveSettings();
    notifyListeners();
  }

  // 设置提前提醒天数
  Future<void> setExpiryNotificationDays(int days) async {
    _expiryNotificationDays = days;
    await _saveSettings();
    notifyListeners();
  }

  // 设置提醒时间
  Future<void> setExpiryNotificationTime(String time) async {
    _expiryNotificationTime = time;
    await _saveSettings();
    notifyListeners();
  }

  // 设置当前用户ID
  Future<void> setCurrentUserId(String userId) async {
    _currentUserId = userId;
    await _saveSettings();
    notifyListeners();
  }
}
