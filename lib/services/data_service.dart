import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/portfolio_data.dart';

/// Loads portfolio content from the bundled JSON asset.
/// Keeping data access behind a service makes it trivial to later
/// swap this for a remote API/CMS without touching any view code.
class DataService {
  static const String _dataPath = 'assets/data/portfolio_data.json';

  Future<PortfolioData> loadPortfolioData() async {
    final raw = await rootBundle.loadString(_dataPath);
    final Map<String, dynamic> jsonMap = json.decode(raw);
    return PortfolioData.fromJson(jsonMap);
  }
}
