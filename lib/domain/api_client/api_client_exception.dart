enum ApiClientExceptionType { network, tooManyRequests, internalServerError, notCorrectResults, wrongUrl }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}
