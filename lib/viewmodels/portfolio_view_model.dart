import 'package:flutter/foundation.dart';
import '../models/portfolio_data.dart';
import '../services/data_service.dart';

enum LoadStatus { loading, success, error }

/// Owns the lifecycle of loading portfolio content from JSON and
/// exposes it to every view via Provider. Views never talk to
/// DataService directly -- this is the single source of truth.
class PortfolioViewModel extends ChangeNotifier {
  final DataService _dataService;

  PortfolioViewModel({DataService? dataService})
      : _dataService = dataService ?? DataService() {
    _load();
  }

  LoadStatus _status = LoadStatus.loading;
  LoadStatus get status => _status;

  PortfolioData? _data;
  PortfolioData? get data => _data;

  String? _error;
  String? get error => _error;

  Future<void> _load() async {
    try {
      _status = LoadStatus.loading;
      notifyListeners();
      final result = await _dataService.loadPortfolioData();
      _data = result;
      _status = LoadStatus.success;
    } catch (e) {
      _error = e.toString();
      _status = LoadStatus.error;
    }
    notifyListeners();
  }

  Future<void> retry() => _load();

  // Convenience visibility flags so views can hide sections whose
  // resume data is missing, without duplicating the null-check logic.
  bool get hasProjects => (_data?.projects.isNotEmpty ?? false);
  bool get hasExperience => (_data?.experience.isNotEmpty ?? false);
  bool get hasEducation => (_data?.education.isNotEmpty ?? false);
  bool get hasCertificates => (_data?.certificates.isNotEmpty ?? false);
  bool get hasAchievements => (_data?.achievements.isNotEmpty ?? false);
  bool get hasServices => (_data?.services.isNotEmpty ?? false);
  bool get hasSkills => (_data?.skills.isNotEmpty ?? false);
}
