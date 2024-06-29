import 'package:flutter/material.dart';
import 'package:pathfinder/config/configuration.dart';
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
    if (!_isValid(urlPath)) {
      _updateState(
          "Wrong URL, please use https://flutter.webspark.dev/flutter/api. You may use get parameters as well.");
      return;
    }

    _updateState(null);
    pathDataService.setUrlPath(urlPath);

    Navigator.of(context).pushNamed(MainNavigationRouteNames.processScreen);
  }

  bool _isValid(String uri) {
    var regExp = RegExp(Configuration.host);
    var match = regExp.hasMatch(uri);
    return match;
  }

  void _updateState(String? errorMessage) {
    if (_errorMessage == errorMessage) return;
    _errorMessage = errorMessage;
    notifyListeners();
  }
}
