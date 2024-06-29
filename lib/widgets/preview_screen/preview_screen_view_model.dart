import 'package:pathfinder/services/path_data_service.dart';
import 'package:pathfinder/services/solution_data.dart';

class PreviewScreenViewModel {
  final PathDataService pathDataService;
  final int index;

  PreviewScreenViewModel(this.pathDataService, this.index);

  SolutionData get solutionData => pathDataService.solutionsList[index];
}