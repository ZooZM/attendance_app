import 'package:dio/dio.dart';

abstract class Failure {
  final String failurMsg;

  Failure(this.failurMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.failurMsg);

  factory ServerFailure.fromDioException(DioException dioException) {
    final message = dioException.message ?? 'Unknown error';

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout, please try again later');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout, please try again later');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout, please try again later');

      case DioExceptionType.badCertificate:
        return ServerFailure('Something happened, please try again later');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response,
        );

      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error, please try again later');

      case DioExceptionType.unknown:
        if (message.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('There was an Error, please try again later');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    final dynamic responseData = response is Response
        ? response.data
        : response;

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        responseData is Map<String, dynamic> &&
                responseData.containsKey('error')
            ? responseData['error']['message'] ?? 'Unknown error'
            : 'Unknown error',
      );
    } else if (statusCode == 404) {
      return ServerFailure('Error 404: Your request not Found');
    } else {
      return ServerFailure('There was an Error, please try again later');
    }
  }
}

class VerificationFailure extends Failure {
  final String email;
  VerificationFailure(this.email) : super('');
}
