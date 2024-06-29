import 'package:flutter/material.dart';
import 'package:pathfinder/domain/api_client/api_client_exception.dart';
import 'package:pathfinder/navigation/main_navigation.dart';
import 'package:pathfinder/services/path_data_service.dart';

class ProcessScreenViewModel extends ChangeNotifier {
  final PathDataService pathDataService;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  static const loadDataDelta = 50;

  int _progressValue = 0;

  int get progressValue => _progressValue;

  bool get isCompleted => _progressValue >= 100;

  ProcessScreenViewModel(this.pathDataService);

  Future<void> startProcess(BuildContext context) async {
    try {
      await pathDataService.loadDataFromServer();
    } on ApiClientException catch (_) {
      _errorMessage = "Wrong URL, please fix it and try again.";
      if (context.mounted) {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.homeScreen, arguments: _errorMessage);
      }
      return;
    }
    _progressValue += loadDataDelta;
    notifyListeners();

    int tasksAmount = pathDataService.tasksAmount;

    if (tasksAmount == 0) {
      _errorMessage = "Something went wrong, no tasks from server. Please, try again later.";
    }

    int delta = ((100 - loadDataDelta) / tasksAmount).floor();
    for (int i = 0; i < tasksAmount; i++) {
      pathDataService.calcNextSolution(i);
      _progressValue += delta;
      notifyListeners();
    }
  }

  Future<void> sendResultsToServer(BuildContext context) async {
    _errorMessage = await pathDataService.validateData();

    notifyListeners();

    if (_errorMessage == null && context.mounted) {
      Navigator.of(context).pushNamed(MainNavigationRouteNames.resultScreen);
    }
  }
}
