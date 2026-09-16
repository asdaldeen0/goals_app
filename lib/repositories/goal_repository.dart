import 'package:get_storage/get_storage.dart';
import '../models/goal_model.dart';

class GoalRepository {
  static const String _storageKey = 'user_goals';
  static const String _userNameKey = 'user_name';
  static const String _notificationsEnabledKey = 'notifications_enabled';

  final GetStorage _box = GetStorage();

  List<GoalModel> loadGoals() {
    final List<dynamic>? rawList = _box.read<List<dynamic>>(_storageKey);
    if (rawList == null || rawList.isEmpty) {
      return [];
    }

    return rawList
        .map((item) => GoalModel.fromMap(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  Future<void> saveGoals(List<GoalModel> goals) async {
    final list = goals.map((goal) => goal.toMap()).toList();
    await _box.write(_storageKey, list);
  }

  String loadUserName() {
    return _box.read<String>(_userNameKey) ?? 'بطل';
  }

  Future<void> saveUserName(String name) async {
    await _box.write(_userNameKey, name.trim());
  }

  bool loadNotificationsEnabled() {
    return _box.read<bool>(_notificationsEnabledKey) ?? true;
  }

  Future<void> saveNotificationsEnabled(bool enabled) async {
    await _box.write(_notificationsEnabledKey, enabled);
  }

  Future<void> clearGoals() async {
    await _box.remove(_storageKey);
  }
}
