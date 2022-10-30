import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'contains.dart';

class CustomExceptions extends IActionException {
  /// get exceptions type [_type]
  get type => _type;

  /// override message error of interface Exception
  @override
  String toString() {
    return _message ?? super.toString();
  }

  /// func handle exception of All error
  @override
  String getException(dynamic error, {IActionException? iActionTmp}) {
    _iAction = iActionTmp ??= this;
    if (error is Exception) {
      try {
        if (error is DioError) {
          debugPrint("DioError : ${error.message}");
          switch (error.type) {
            case DioErrorType.cancel:
              _message = "Exception Request Cancelled";
              _type = ExceptionType.TYPE_CANCEL;
              _iAction?.requestCancelled();
              break;
            case DioErrorType.connectTimeout:
              _message = "Exception Connection request timeout";
              _type = ExceptionType.TYPE_CONNECT_TIMEOUT;
              _iAction?.requestTimeout();
              break;
            case DioErrorType.sendTimeout:
              _message = "Exception Send timeout in connection with API server";
              _type = ExceptionType.TYPE_SEND_TIMEOUT;
              _iAction?.sendTimeout();
              break;
            case DioErrorType.receiveTimeout:
              _message =
                  "Exception Receive Timeout in connection with API server";
              _type = ExceptionType.TYPE_RECEIVE_TIMEOUT;
              _iAction?.receiveTimeout();
              break;
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case Contains.STATUS_CODE_400:
                  _message = "Exception Unauthorised request";
                  _type = ExceptionType.TYPE_400;
                  _iAction?.unauthorisedRequest();
                  break;
                case Contains.STATUS_CODE_401:
                  _message = "Exception Unauthorised request";
                  _type = ExceptionType.TYPE_401;
                  _iAction?.unauthorisedRequest();
                  break;
                case Contains.STATUS_CODE_403:
                  _message = "Exception Unauthorised request";
                  _type = ExceptionType.TYPE_403;
                  _iAction?.unauthorisedRequest();
                  break;
                case Contains.STATUS_CODE_404:
                  _type = ExceptionType.TYPE_404;
                  _iAction?.notFound();
                  _message = error.message;
                  break;
                case Contains.STATUS_CODE_409:
                  _message = "Exception Error due to a conflict";
                  _type = ExceptionType.TYPE_409;
                  _iAction?.conflict();
                  break;
                case Contains.STATUS_CODE_408:
                  _message = "Exception Connection request timeout";
                  _type = ExceptionType.TYPE_408;
                  _iAction?.requestTimeout();
                  break;
                case Contains.STATUS_CODE_500:
                  _message = "Exception Internal Server Error";
                  _type = ExceptionType.TYPE_500;
                  _iAction?.internalServerError();
                  break;
                case Contains.STATUS_CODE_503:
                  _message = "Exception Service unavailable";
                  _type = ExceptionType.TYPE_503;
                  _iAction?.serviceUnavailable();
                  break;
                default:
                  _message =
                      "Exception Received invalid status code:= ${error.response?.statusCode}";
                  _type = ExceptionType.TYPE_DEFAULT;
                  _iAction?.defaultError();
              }
              break;
            case DioErrorType.other:
              _message =
                  "Exception with status code:= ${error.response?.statusCode}";
              _type = ExceptionType.TYPE_DEFAULT;
              _iAction?.defaultError();
              break;
          }
        } else if (error is SocketException) {
          debugPrint("SocketException : ${error.message}");
          _message = "Exception No internet connection";
          _type = ExceptionType.TYPE_NO_INTERNET;
          _iAction?.noInternetConnection();
        } else if (error is TimeoutException) {
          debugPrint("TimeoutException: message: ${error.message}");
          _message = "Exception Timeout error occurred";
          _type = ExceptionType.TYPE_SEND_TIMEOUT;
          _iAction?.sendTimeout();
        } else {
          _message = "Exception Unexpected error occurred";
          _type = ExceptionType.TYPE_UNEXPECTED_ERROR;
          _iAction?.unexpectedError();
        }
        return _message!;
      } on FormatException catch (e) {
        debugPrint("FormatException: ${e.message}");
        _message = "Exception Format error occurred";
        _type = ExceptionType.TYPE_FORMAT_EXCEPTION;
        _iAction?.formatException();
      } catch (e) {
        _message = "Exception Unexpected error occurred";
        _type = ExceptionType.TYPE_UNEXPECTED_ERROR;
        _iAction?.unexpectedError();
      }
      return _message!;
    } else {
      if (error is NullThrownError) {
        debugPrint("NullThrownError with data null");
        _message = "Exception Null Data error occurred";
        _type = ExceptionType.TYPE_NULL_THROWN_ERROR;
        _iAction?.nullThrownError();
      } else if (error.toString().contains("is not a subtype of")) {
        debugPrint("Exception not a subtype o: $error");
        _message = "Exception value is not a type of data";
        _type = ExceptionType.TYPE_UNABLE_TO_PROCESS;
        _iAction?.unableToProcess();
      } else {
        debugPrint("Exception Not define: $error}");
        _message = "Exception Unexpected error occurred";
        _type = ExceptionType.TYPE_UNEXPECTED_ERROR;
        _iAction?.unexpectedError();
      }
      return _message!;
    }
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) {
    return toString() == other.toString();
  }
}

abstract class IActionException implements Exception {
  late IActionException? _iAction;
  String? _message;
  ExceptionType _type = ExceptionType.TYPE_DEFAULT;

  String getException(dynamic error, {IActionException? iActionTmp}) {
    debugPrint("getException message: = $_message --- type:= ${_type.name}");
    return "$_message";
  }

  void requestCancelled() {
    debugPrint(
        "requestCancelled message: = $_message --- type:= ${_type.name}");
  }

  void unauthorisedRequest() {
    debugPrint(
        "unauthorisedRequest message: = $_message --- type:= ${_type.name}");
  }

  void badRequest() {
    debugPrint("badRequest message: = $_message --- type:= ${_type.name}");
  }

  void notFound() {
    debugPrint("notFound message: = $_message --- type:= ${_type.name}");
  }

  void methodNotAllowed() {
    debugPrint(
        "methodNotAllowed message: = $_message --- type:= ${_type.name}");
  }

  void notAcceptable() {
    debugPrint("notAcceptable message: = $_message --- type:= ${_type.name}");
  }

  void requestTimeout() {
    debugPrint("requestTimeout message: = $_message --- type:= ${_type.name}");
  }

  void sendTimeout() {
    debugPrint("sendTimeout message: = $_message --- type:= ${_type.name}");
  }

  void conflict() {
    debugPrint("conflict message: = $_message --- type:= ${_type.name}");
  }

  void internalServerError() {
    debugPrint(
        "internalServerError message: = $_message --- type:= ${_type.name}");
  }

  void notImplemented() {
    debugPrint("notImplemented message: = $_message --- type:= ${_type.name}");
  }

  void serviceUnavailable() {
    debugPrint(
        "serviceUnavailable message: = $_message --- type:= ${_type.name}");
  }

  void receiveTimeout() {
    debugPrint("receiveTimeout message: = $_message --- type:= ${_type.name}");
  }

  void noInternetConnection() {
    debugPrint(
        "noInternetConnection message: = $_message --- type:= ${_type.name}");
  }

  void formatException() {
    debugPrint("formatException message: = $_message --- type:= ${_type.name}");
  }

  void nullThrownError() {
    debugPrint("nullThrownError message: = $_message --- type:= ${_type.name}");
  }

  void unableToProcess() {
    debugPrint("unableToProcess message: = $_message --- type:= ${_type.name}");
  }

  void defaultError() {
    debugPrint("defaultError message: = $_message --- type:= ${_type.name}");
  }

  void unexpectedError() {
    debugPrint("unexpectedError message: = $_message --- type:= ${_type.name}");
  }
}

enum ExceptionType {
  TYPE_CANCEL,
  TYPE_CONNECT_TIMEOUT,
  TYPE_DEFAULT,
  TYPE_RECEIVE_TIMEOUT,
  TYPE_RESPONSE,
  TYPE_SEND_TIMEOUT,
  TYPE_NO_INTERNET,
  TYPE_UNEXPECTED_ERROR,
  TYPE_FORMAT_EXCEPTION,
  TYPE_UNABLE_TO_PROCESS,
  TYPE_NULL_THROWN_ERROR,
  TYPE_400,
  TYPE_401,
  TYPE_403,
  TYPE_404,
  TYPE_409,
  TYPE_408,
  TYPE_500,
  TYPE_503,
}
