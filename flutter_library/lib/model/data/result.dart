import 'package:flutter_library/model/navigate_model.dart';

import '../../utils/custom_exception.dart';

abstract class Result<T>{
  const factory Result.success({required T data}) = ResultSuccess;
  const factory Result.fail({required dynamic error, IActionException? iAction}) = ResultFail;
  const factory Result.loading({required bool loading}) = ResultLoading;
  const factory Result.navigate({required NavigateModel navigateModel}) = ResultNavigate;
  const factory Result.showToast({required String message}) = ResultShowToast;
}

class ResultSuccess<T> implements Result<T>{
  final T data;

  const ResultSuccess({required this.data});
}

class ResultFail<T> implements Result<T>{
  final dynamic error;
  final IActionException? iAction;

  const ResultFail({required this.error,this.iAction});
}

class ResultLoading<T> implements Result<T>{
  final bool loading;

  const ResultLoading({required this.loading});
}

class ResultNavigate<T> implements Result<T>{
  final NavigateModel navigateModel;
  const ResultNavigate({required this.navigateModel});
}

class ResultShowToast<T> implements Result<T>{
  final String message;
  const ResultShowToast({required this.message});
}
