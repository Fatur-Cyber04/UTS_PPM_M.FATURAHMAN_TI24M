import '../models/activity_model.dart';

/// DATA: sumber data sementara (disimpan di List selama aplikasi berjalan).
class ActivityData {
  int _nextId = 4;

  final List<ActivityModel> activities = [
    ActivityModel(id: 1, name: 'Push Up', counter: 10),
    ActivityModel(id: 2, name: 'Baca Buku', counter: 3),
    ActivityModel(id: 3, name: 'Minum Air Putih', counter: 5),
  ];

  int generateId() => _nextId++;
}
