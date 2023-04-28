// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../fast_tools/widgets/custom_text_field.dart';
import '../../../../../fast_tools/widgets/screen_wrapper.dart';
import '../../../../../fast_tools/widgets/v_space.dart';
import '../../../../../init/runtime_variables.dart';
import '../../../../theming/constants/sizes.dart';
import '../../../domain/entities/message_entity.dart';
import 'widgets/message.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/ChatScreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messagesController = TextEditingController();
  ScrollController messagesScroll = ScrollController();
  bool loadingAllMessages = false;
  List<MessageModel> messages = [];
  void loadAllData() async {
    setState(() {
      loadingAllMessages = true;
    });
    try {
      var data = await FirebaseDatabase.instance
          .ref('messages')
          .limitToLast(100)
          .get();
      (data.value as Map<String, dynamic>).forEach((key, value) {
        if (!messages.any((element) => element.id == key)) {
          messages.add(MessageModel.fromJson(key, value));
        }
      });
    } catch (e) {
      logger.e('error loading messages');
    }
    setState(() {
      loadingAllMessages = false;
    });
  }

  bool sendingMessage = false;
  void sendMessage(String m) async {
    if (m.trim().isEmpty) return;
    try {
      messagesController.text = '';

      setState(() {
        sendingMessage = true;
      });
      var ref = FirebaseDatabase.instance.ref('messages').push();
      await ref.set({
        'name': 'Amr Hassan',
        'email': 'amrhassan@gmail.com',
        'message': m,
      });
      // Scroll to the end of the list
    } catch (e) {
      messagesController.text = m;
    }
    setState(() {
      sendingMessage = false;
    });
  }

  @override
  void initState() {
    loadAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kHPad, vertical: kVPad),
              child: StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance
                    .ref('messages')
                    .limitToLast(1)
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.snapshot.value == null) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var values =
                      snapshot.data!.snapshot.value as Map<String, dynamic>;

                  for (var element in values.entries) {
                    if (!messages.any((e) => e.id == element.key)) {
                      messages.add(
                          MessageModel.fromJson(element.key, element.value));
                    }
                  }
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    messagesScroll.animateTo(
                      messagesScroll.position.maxScrollExtent,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeOut,
                    );
                  });
                  return ListView.builder(
                    controller: messagesScroll,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => MessageWidget(
                      messageModel: messages.elementAt(index),
                    ),
                  );
                },
              ),
            ),
          ),
          CustomTextField(
            controller: messagesController,
            title: 'Enter your message',
            onSubmitted: sendMessage,
            trailingIcon: sendingMessage ? CircularProgressIndicator() : null,
          ),
          VSpace(),
        ],
      ),
    );
  }
}
