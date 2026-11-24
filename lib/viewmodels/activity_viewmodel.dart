import 'package:flutter/foundation.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

/// VIEWMODEL: logika aplikasi + state. Memberi tahu View lewat notifyListeners().
class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository;

  ActivityViewModel(this._repository);

  List<ActivityModel> get activities => _repository.getAll();

  ActivityModel? getById(int id) => _repository.getById(id);

  void addActivity(String name) {
    _repository.add(name.trim());
    notifyListeners();
  }

  void updateActivity(int id, String name) {
    _repository.update(id, name.trim());
    notifyListeners();
  }

  void deleteActivity(int id) {
    _repository.delete(id);
    notifyListeners();
  }

  /// Mengembalikan true jika berhasil.
  bool increment(int id) {
    final a = _repository.getById(id);
    if (a == null) return false;
    _repository.updateCounter(id, a.counter + 1);
    notifyListeners();
    return true;
  }

  /// Mengembalikan false jika sudah 0 (counter tidak boleh < 0).
  bool decrement(int id) {
    final a = _repository.getById(id);
    if (a == null || a.counter <= 0) return false;
    _repository.updateCounter(id, a.counter - 1);
    notifyListeners();
    return true;
  }

  void reset(int id) {
    _repository.updateCounter(id, 0);
    notifyListeners();
  }
}
