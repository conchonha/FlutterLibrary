// import 'package:dio/dio.dart';
//
// class NetworkExceptionsIplm implements NetworkExceptions{
//   @override
//   late DioErrorType dioErrorType;
//
//   @override
//   late String message;
//
//   @override
//   late int statusCode;
//
//   NetworkExceptionsIplm.onError(Object? error){
//     handleError(error);
//   }
//
//   void handleError(Object? error){
//     if(error is DioError){
//       switch(error.type){
//         case DioErrorType.cancel:
//
//       }
//     }
//   }
//
//   @override
//   void conflict() {
//   }
//
//   @override
//   void defaultError(String error) {
//   }
//
//   @override
//   void formatException() {
//   }
//
//   @override
//   void internalServerError() {
//   }
//
//   @override
//   void noInternetConnection() {
//   }
//
//   @override
//   void notFound(String message) {
//   }
//
//   @override
//   void requestCancelled() {
//   }
//
//   @override
//   void requestTimeout() {
//   }
//
//   @override
//   void sendTimeout() {
//   }
//
//   @override
//   void serviceUnavailable() {
//   }
//
//   @override
//   void unauthorisedRequest() {
//   }
//
//   @override
//   void unexpectedError() {
//   }
// }
//
//
// abstract class NetworkExceptions{
//   late DioErrorType dioErrorType;
//   late int statusCode;
//   late String message;
//
//   void requestCancelled();
//   void requestTimeout();
//   void noInternetConnection();
//   void sendTimeout();
//   void unauthorisedRequest();
//   void notFound(String message);
//   void conflict();
//   void internalServerError();
//   void serviceUnavailable();
//   void defaultError(String error);
//   void unexpectedError();
//   void formatException();
// }
//
//
