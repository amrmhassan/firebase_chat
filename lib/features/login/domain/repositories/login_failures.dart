import 'package:firebase_chat/core/errors/failure.dart';

class EmptyCredFailures implements Failure {}

class NoNetworkFailure implements Failure {}

class WrongCredFailure implements Failure {}

class NoUserFailure implements Failure {}

class InvalidEmailFailure implements Failure {}

class WrongPasswordFailure implements Failure {}

class EmailExistsWithDifferentProviderFailure implements Failure {}

// sign up errors
class EmailAlreadyCreatedFailure implements Failure {}

// google auth
class NotSignedInWithGoogleFailure implements Failure {}

class InsufficientGoogleInfoFailure implements Failure {}

// validation failure
class ValidationFailure implements Failure {}

// facebook failures
class FacebookAuthNotGranted implements Failure {}

class InsufficientFacebookInfoFailure implements Failure {}
