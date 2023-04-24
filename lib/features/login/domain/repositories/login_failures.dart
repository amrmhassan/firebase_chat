import 'package:firebase_chat/core/errors/failure.dart';

class EmptyCredFailures implements Failure {}

class NoNetworkFailure implements Failure {}

class WrongCredFailure implements Failure {}

class NoUserFailure implements Failure {}

class InvalidEmailFailure implements Failure {}
