import 'dart:convert';

import 'package:firebase_chat/features/auth/data/models/temp_mail_model.dart';
import 'package:http/http.dart' as http;

class APITransformer {
  static Future<TempMailModel> getDisposalEmail({
    required String apiKey,
    required String email,
  }) async {
    String url =
        'https://emailvalidation.abstractapi.com/v1/?api_key=$apiKey&email=$email';
    var res = await http.get(Uri.parse(url));
    var body = json.decode(res.body);
    return TempMailModel.fromJSON(body);
  }
}
