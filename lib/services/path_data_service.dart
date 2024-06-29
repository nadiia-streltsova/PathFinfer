import 'package:pathfinder/domain/api_client/api_client_exception.dart';
import 'package:pathfinder/domain/api_client/network_client.dart';
import 'package:pathfinder/domain/entities/data_entity.dart';
import 'package:pathfinder/finder/engine.dart';
import 'package:pathfinder/services/solution_data.dart';
import 'package:pathfinder/services/stored_data_provider.dart';

class PathDataService {
  final _networkClient = NetworkClient();
  final engine = Engine();
  final _storedDataProvider = StoredDataProvider();

  List<TaskDataEntity> _taskList = [];
  final List<SolutionData> _solutionsList = [];
  List<SolutionData> get solutionsList => _solutionsList;

  int get tasksAmount => _taskList.length;

  void setUrlPath(String path) {
    _storedDataProvider.setUrlPath(path);
  }

  Future<void> loadDataFromServer() async {
    _taskList.clear();
    _solutionsList.clear();
    final path = await _storedDataProvider.getUrlPath();
    try {
      _taskList = (await _networkClient.getData(path!)).data;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.wrongUrl);
    }
  }

  void calcNextSolution(int index) {
    if (index >= tasksAmount) return;
    var solution = engine.findPath(_taskList[index]);
    _solutionsList.add(solution);
  }

  Future<String?> validateData() async {
    final path = await _storedDataProvider.getUrlPath();
    List<Map<String, dynamic>> params = [];
    for (var data in _solutionsList) {
      params.add({
        "id": data.id,
        "result": ({"steps": data.steps, "path": data.pathString}),
      });
    }

    try {
      _networkClient.validateData(path!, params);
    } on ApiClientException catch (error) {
      switch (error.type) {
        case ApiClientExceptionType.notCorrectResults:
          return "Results is not correct";
        case ApiClientExceptionType.tooManyRequests:
          return "Too Many Requests";
        case ApiClientExceptionType.internalServerError:
          return "Internal Server Error";
        case ApiClientExceptionType.network:
          return "Something went wrong, please try again.";
        case ApiClientExceptionType.wrongUrl:
          return "Wrong URL, please fix it and try again.";
      }
    }
    return null;
  }
}
