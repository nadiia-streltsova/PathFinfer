import 'package:pathfinder/domain/entities/data_entity.dart';
import 'package:pathfinder/finder/cell_item.dart';

class SolutionData {
  final String id;
  final List<List<CellItem>> field;
  final String pathString;
  final List<Position> steps;

  SolutionData({
    required this.id,
    required this.field,
    required this.pathString,
    required this.steps,
  });
}
