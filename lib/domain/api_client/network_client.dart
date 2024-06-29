import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pathfinder/domain/api_client/api_client_exception.dart';
import 'package:pathfinder/domain/entities/data_entity.dart';

class NetworkClient {
  final _dio = Dio();

  Future<void> validateData(
    String path,
    List<Map<String, dynamic>> bodyParams,
  ) async {
    try {
      Response response = await _dio.post(
        path,
        options: Options(headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(bodyParams),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 400) {
        throw ApiClientException(ApiClientExceptionType.notCorrectResults);
      }
      if (error.response?.statusCode == 429) {
        throw ApiClientException(ApiClientExceptionType.tooManyRequests);
      } else if (error.response?.statusCode == 500) {
        throw ApiClientException(ApiClientExceptionType.internalServerError);
      }
    }
  }

  Future<TasksListEntity> getData(String path) async {
    Response response;
    response = await _dio.get(path);
    return TasksListEntity.fromJson(response.data);
  }
}
