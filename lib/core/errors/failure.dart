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
      return 'User not found, sign up please!';
    } else if (failure is EmptyCredFailures) {
      return 'Please enter email and password';
    } else if (failure is InvalidEmailFailure) {
      return 'Invalid email';
    }

    return 'Unknown error';
  }
}