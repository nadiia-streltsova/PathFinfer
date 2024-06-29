import 'package:flutter/material.dart';
import 'package:pathfinder/navigation/main_navigation.dart';
import 'package:pathfinder/services/path_data_service.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final PathDataService pathDataService;

  final uriTextController = TextEditingController();

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  HomeScreenViewModel(this.pathDataService, this._errorMessage);

  void startProcess(BuildContext context) async {
    final urlPath = uriTextController.text;

    _updateState(null);
    pathDataService.setUrlPath(urlPath);

    Navigator.of(context).pushNamed(MainNavigationRouteNames.processScreen);
  }

  void _updateState(String? errorMessage) {
    if (_errorMessage == errorMessage) return;
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
