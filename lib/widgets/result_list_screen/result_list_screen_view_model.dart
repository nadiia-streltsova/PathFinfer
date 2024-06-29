import 'package:flutter/cupertino.dart';
import 'package:pathfinder/navigation/main_navigation.dart';
import 'package:pathfinder/services/path_data_service.dart';
import 'package:pathfinder/services/solution_data.dart';

class ResultListScreenViewModel {
  final PathDataService pathDataService;

  ResultListScreenViewModel(this.pathDataService);

  List<SolutionData> get solutionsList => pathDataService.solutionsList;

  void showResult(BuildContext context, int index) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.previewScreen, arguments: index);
  }
}