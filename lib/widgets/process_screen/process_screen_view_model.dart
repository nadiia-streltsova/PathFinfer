import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pathfinder/domain/api_client/api_client_exception.dart';
import 'package:pathfinder/navigation/main_navigation.dart';
import 'package:pathfinder/services/path_data_service.dart';

class ProcessScreenViewModel extends ChangeNotifier {
  final PathDataService pathDataService;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  static const _loadDataDelta = 80;

  int _progressValue = 0;
  int _animationLoadPercent= 0;

  int get progressValue => _progressValue;

  bool _isSendingResults = false;
  bool get isCompleted => _progressValue >= 100 && !_isSendingResults;

  Timer? _timer;

  ProcessScreenViewModel(this.pathDataService);

  Future<void> startProcess(BuildContext context) async {
    startTimer();
    try {
      await pathDataService.loadDataFromServer();
    } on ApiClientException catch (_) {
      _errorMessage = "Wrong URL, please fix it and try again.";
      if (context.mounted) {
        Navigator.of(context).pushNamed(MainNavigationRouteNames.homeScreen, arguments: _errorMessage);
      }
      return;
    }

    int tasksAmount = pathDataService.tasksAmount;

    if (tasksAmount == 0) {
      _errorMessage = "Something went wrong, no tasks from server. Please, try again later.";
    }

    int delta = ((100 - _loadDataDelta) / tasksAmount).floor();
    for (int i = 0; i < tasksAmount; i++) {
      pathDataService.calcNextSolution(i);
      _progressValue += delta;
      notifyListeners();
    }
  }

  void startTimer() {
    const duration = Duration(milliseconds: 100);
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        if (_loadDataDelta <= _animationLoadPercent) {
          timer.cancel();
        } else {
          _animationLoadPercent++;
          _progressValue++;
          notifyListeners();
        }
      },
    );
  }

  Future<void> sendResultsToServer(BuildContext context) async {
    _isSendingResults = true;
    notifyListeners();

    _errorMessage = await pathDataService.validateData();

    _isSendingResults = false;
    notifyListeners();

    if (_errorMessage == null && context.mounted) {
      Navigator.of(context).pushNamed(MainNavigationRouteNames.resultScreen);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
