import 'package:json_annotation/json_annotation.dart';

part 'data_entity.g.dart';

@JsonSerializable()
class TasksListEntity {
  final bool error;
  final List<TaskDataEntity> data;

  TasksListEntity({
    required this.error,
    required this.data,
  });

  factory TasksListEntity.fromJson(Map<String, dynamic> json) => _$TasksListEntityFromJson(json);
  Map<String, dynamic> toJson() => _$TasksListEntityToJson(this);
}

@JsonSerializable()
class TaskDataEntity {
  final String id;
  final List<String> field;
  final Position start;
  final Position end;

  TaskDataEntity({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory TaskDataEntity.fromJson(Map<String, dynamic> json) => _$TaskDataEntityFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDataEntityToJson(this);
}

@JsonSerializable()
class Position {
  final int x;
  final int y;

  Position({
    required this.x,
    required this.y,
  });

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);

  @override
  String toString() {
    return '($x,$y)';
  }
}
