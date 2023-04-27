// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/core/navigation.dart';
import 'package:firebase_chat/fast_tools/widgets/button_wrapper.dart';
import 'package:firebase_chat/fast_tools/widgets/v_space.dart';
import 'package:firebase_chat/features/email_verification/presentation/providers/email_verification_provider.dart';
import 'package:firebase_chat/features/home/presentation/pages/home_screen.dart';
import 'package:firebase_chat/features/theming/constants/sizes.dart';
import 'package:firebase_chat/features/theming/constants/styles.dart';
import 'package:firebase_chat/features/theming/theme_calls.dart';
import 'package:firebase_chat/utils/global_utils.dart';
import 'package:firebase_chat/utils/providers_calls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String routeName = '/EmailVerificationScreen';
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    runVerificationChecker();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
      ),
      body: Align(
        child: SingleChildScrollView(
          child: StreamBuilder<Duration?>(
              stream: Providers.emailVPf(context).remainingTimeStream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Image.asset(
                      'assets/icons/email.png',
                      width: largeIconSize * 3,
                    ),
                    VSpace(factor: .5),
                    Selector<EVerifyProvider, bool>(
                      selector: (p0, p1) => p1.emailSent,
                      builder: (context, value, child) => Text(
                        value
                            ? 'Email sent! Please check your email box.'
                            : 'You need to verify your email first',
                        style: h4TextStyleInactive,
                      ),
                      shouldRebuild: (previous, next) => previous != next,
                    ),
                    VSpace(factor: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWrapper(
                          active: snapshot.data == null,
                          padding: EdgeInsets.symmetric(
                            horizontal: kHPad,
                            vertical: kVPad / 2,
                          ),
                          backgroundColor: colorTheme.kBlueColor,
                          onTap: () {
                            Providers.emailVPf(context).sendEmail();
                          },
                          child: Selector<EVerifyProvider, bool>(
                            selector: (p0, p1) => p1.emailSent,
                            builder: (context, value, child) => Text(
                              value ? 'Resend Email' : 'Send Email',
                              style: h4LightTextStyle,
                            ),
                            shouldRebuild: (previous, next) => previous != next,
                          ),
                        ),
                      ],
                    ),
                    VSpace(factor: .4),
                    if (snapshot.data != null)
                      Text(
                        'Wait ${GlobalUtils.formatDuration(
                          snapshot.data!,
                        )}',
                        style: h4TextStyleInactive,
                      )
                  ],
                );
              }),
        ),
      ),
    );
  }

  void runVerificationChecker() {
    Future.delayed(Duration.zero).then((value) async {
      await Providers.emailVPf(context).loadSentAt();
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      if (user.emailVerified) {
        Providers.emailVPf(context).emailVerified();
        CNav.pushReplacementNamed(context, HomeScreen.routeName);
      }

      if (!user.emailVerified) {
        Timer.periodic(Duration(seconds: 5), (timer) async {
          await user.reload();

          if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
            if (mounted) {
              Providers.emailVPf(context).emailVerified();
            }

            timer.cancel();
          }
        });
      }
    });
  }
}
