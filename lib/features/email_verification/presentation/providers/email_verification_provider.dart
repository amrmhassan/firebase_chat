// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/fast_tools/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';

import '../../../../fast_tools/constants/shared_pref_constants.dart';

class EVerifyProvider extends ChangeNotifier {
  // this is the minimum time the user have to wait before asking for another verification email
  static const Duration minimumForResend = Duration(minutes: 2);
  DateTime? _sentAt;
  bool emailSent = false;

  Stream<Duration?> get remainingTimeStream => Stream.periodic(
        Duration(milliseconds: 500),
        (computationCount) {
          if (_remainingDuration == null) return null;
          if (_remainingDuration!.isNegative) {
            _sentAt = null;
            return null;
          }
          return _remainingDuration;
        },
      );

  Duration? get _remainingDuration {
    if (_sentAt == null) return null;
    DateTime futureTime = _sentAt!.add(minimumForResend);
    DateTime now = DateTime.now();
    return futureTime.difference(now);
  }

  void sendEmail() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    user.sendEmailVerification();
    _sentAt = DateTime.now();
    emailSent = true;
    _saveToSharedPref();
  }

  Future<void> _saveToSharedPref() async {
    await SharedPrefHelper.setString(
      lastEmailVerificationSentKey,
      _sentAt!.toIso8601String(),
    );
    await SharedPrefHelper.setBool(
      emailSentKey,
      true,
    );
  }

  Future<void> loadSentAt() async {
    String? sentAt =
        await SharedPrefHelper.getString(lastEmailVerificationSentKey);
    if (sentAt == null) return;
    _sentAt = DateTime.parse(sentAt);
    emailSent = (await SharedPrefHelper.getBool(emailSentKey)) ?? false;
    notifyListeners();
  }

  Future<void> emailVerified() async {
    await SharedPrefHelper.removeKey(emailSentKey);
    await SharedPrefHelper.removeKey(lastEmailVerificationSentKey);
  }
}
