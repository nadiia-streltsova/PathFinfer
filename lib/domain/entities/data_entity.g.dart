// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksListEntity _$TasksListEntityFromJson(Map<String, dynamic> json) =>
    TasksListEntity(
      error: json['error'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => TaskDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasksListEntityToJson(TasksListEntity instance) =>
    <String, dynamic>{
      'error': instance.error,
      'data': instance.data,
    };

TaskDataEntity _$TaskDataEntityFromJson(Map<String, dynamic> json) =>
    TaskDataEntity(
      id: json['id'] as String,
      field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
      start: Position.fromJson(json['start'] as Map<String, dynamic>),
      end: Position.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskDataEntityToJson(TaskDataEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'start': instance.start,
      'end': instance.end,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
