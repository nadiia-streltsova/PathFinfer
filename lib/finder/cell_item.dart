import 'package:pathfinder/domain/entities/data_entity.dart';

enum CellType { empty, start, end, onPath, blocked }

class CellItem {
  static const orthogonalWeight = 10;
  static const diagonalWeight = 14;

  final Position position;
  CellItem? leadedNode;
  int _distanceWeight = 0;
  CellType type = CellType.empty;

  bool get isBlocked => type == CellType.blocked;

  int get distanceWeight => _distanceWeight;

  CellItem({
    required this.position,
    this.type = CellType.empty,
  });

  void updateLeadedNode(CellItem newLeadedNode) {
    final bool isOrthogonal =
        newLeadedNode.position.x == position.x || newLeadedNode.position.y == position.y;
    final newWeight =
        (isOrthogonal ? orthogonalWeight : diagonalWeight) + newLeadedNode.distanceWeight;
    if (distanceWeight == 0 || newWeight < distanceWeight) {
      _distanceWeight = newWeight;
      leadedNode = newLeadedNode;
    }
  }

  int _calcHeuristicDistance(Position endPosition) =>
      ((position.x - endPosition.x).abs() + (position.y - endPosition.y).abs()) * 10;

  int getWeight(Position endPosition) {
    return distanceWeight + _calcHeuristicDistance(endPosition);
  }

  @override
  String toString() {
    return '$position';
  }
}
