import 'package:pathfinder/domain/entities/data_entity.dart';
import 'package:pathfinder/finder/cell_item.dart';
import 'dart:math';

import 'package:pathfinder/services/solution_data.dart';

class Engine {

  SolutionData findPath(TaskDataEntity data) {
    var field = _parseField(data);
    var startPosition = data.start;
    var endPosition = data.end;
    var currentItem = field[startPosition.y][startPosition.x];
    String pathString = currentItem.position.toString();
    List<Position> steps = [currentItem.position];
    while (currentItem.type != CellType.end) {
      var neighbours = findNeighbours(field, currentItem);
      for (CellItem item in neighbours) {
        item.updateLeadedNode(currentItem);
      }
      if (neighbours.isNotEmpty) {
        currentItem = neighbours.reduce((curr, next) =>
        curr.getWeight(endPosition) <
            next.getWeight(endPosition) ? curr : next);
        if (currentItem.type == CellType.empty) {
          currentItem.type = CellType.onPath;
        }
        pathString += "->${currentItem.position.toString()}";
        steps.add(currentItem.position);
      }
    }
    return SolutionData(id: data.id, field: field, pathString: pathString, steps: steps);
  }

  bool needToCheck(CellItem currentItem) {
    return currentItem.type == CellType.empty || currentItem.type == CellType.end;
  }

  List<CellItem> findNeighbours(List<List<CellItem>> field, CellItem item) {
    List<List<CellItem>> columns =
    field.sublist(max(item.position.y - 1, 0), min(field.length, item.position.y + 2));
    List<CellItem> neighboursList = columns.map((row) =>
        row.sublist(max(item.position.x - 1, 0), min(row.length, item.position.x + 2)).where((
            element) => needToCheck(element)).toList()).toList().reduce((value, element) =>
    value + element);
    return neighboursList;
  }

  List<List<CellItem>> _parseField(TaskDataEntity taskData) {
    List<String> fieldData = taskData.field;
    List<List<CellItem>> field = [];
    var dataList = fieldData.map((row) => row.split("")).toList();
    for (int i = 0; i < dataList.length; i++) {
      field.add([]);
      for (int j = 0; j < dataList[i].length; j++) {
        field[i].add(CellItem(position: Position(x: j, y: i),
            type: dataList[i][j] == "." ? CellType.empty : CellType.blocked));
      }
    }

    field[taskData.start.y][taskData.start.x].type = CellType.start;
    field[taskData.end.y][taskData.end.x].type = CellType.end;
    return field;
  }
}
