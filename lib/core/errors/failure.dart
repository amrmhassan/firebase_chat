import 'package:dartz/dartz.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';

abstract class Failure {}

class UnknownFailure implements Failure {
  final Object message;
  const UnknownFailure(this.message);

  @override
  String toString() {
    return message.toString();
  }
}

class ErrorMapper {
  final Failure failure;

  const ErrorMapper(this.failure);
  String map() {
    if (failure is NoNetworkFailure) {
      return 'No network';
    } else if (failure is NoUserFailure) {
      return 'User not found';
    } else {
      return 'Unknown error';
    }
  }
}
