// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../../theming/constants/sizes.dart';
import '../../../../domain/entities/message_entity.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel messageModel;
  const MessageWidget({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kHPad,
        vertical: kVPad / 2,
      ),
      child: Text(messageModel.text),
    );
  }
}
