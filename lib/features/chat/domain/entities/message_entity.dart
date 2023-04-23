import 'package:firebase_chat/transformers/models_fields.dart';

class MessageModel {
  final String name;
  final String email;
  final String text;
  final String id;

  const MessageModel({
    required this.email,
    required this.name,
    required this.text,
    required this.id,
  });

  static MessageModel fromJson(String id, Map<String, dynamic> obj) {
    return MessageModel(
      id: obj[ModelsFields.id],
      email: obj[ModelsFields.email],
      name: obj[ModelsFields.name],
      text: obj[ModelsFields.message],
    );
  }
}
