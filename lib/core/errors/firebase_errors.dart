// ignore_for_file: unused_field

import 'package:firebase_chat/core/errors/failure.dart';
import 'package:firebase_chat/features/login/domain/repositories/login_failures.dart';

class FirebaseErrors {
  final String _networkError = 'network-request-failed';
  final String _userNotFound = 'user-not-found';
  final String _invalidEmail = 'invalid-email';
  final String _emailAlreadyCreated = 'email-already-in-use';
  final String _wrongPassword = 'wrong-password';
  final String _emailAlreadySignedWithDifferentWay =
      'account-exists-with-different-credential';

  Map<String, Failure> get _errors => {
        _networkError: NoNetworkFailure(),
      };

  Failure call(String key) {
    return _errors[key] ?? UnknownFailure(key);
  }

  Failure getFailure(String key) {
    if (key == _networkError) {
      return NoNetworkFailure();
    } else if (key == _userNotFound) {
      return NoUserFailure();
    } else if (key == _invalidEmail) {
      return InvalidEmailFailure();
    } else if (key == _emailAlreadyCreated) {
      return EmailAlreadyCreatedFailure();
    } else if (key == _wrongPassword) {
      return WrongPasswordFailure();
    } else if (key == _emailAlreadySignedWithDifferentWay) {
      return EmailExistsWithDifferentProviderFailure();
    }
    return UnknownFailure(key);
  }
}
