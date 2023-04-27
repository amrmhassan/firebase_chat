// ignore_for_file: prefer_const_constructors

import 'package:firebase_chat/transformers/models_fields.dart';

class TempMailModel {
  final String mail;
  final double score;
  final String autoCorrect;
  final bool disposal;
  final bool deliverable;

  const TempMailModel({
    required this.mail,
    required this.score,
    required this.autoCorrect,
    required this.disposal,
    required this.deliverable,
  });

  static TempMailModel fromJSON(Map<String, dynamic> obj) {
    try {
      String email = obj[ModelsFields.email];
      double score = double.parse(obj[ModelsFields.qualityScore]);
      String autocorrect = obj[ModelsFields.autocorrect];
      Map<String, dynamic> disposalInfo = obj[ModelsFields.disposalInfo];
      bool disposal = disposalInfo[ModelsFields.value];
      bool deliverable = obj[ModelsFields.deliverable] == 'DELIVERABLE';

      return TempMailModel(
        mail: email,
        score: score,
        autoCorrect: autocorrect,
        disposal: disposal,
        deliverable: deliverable,
      );
    } catch (e) {
      return _failedModel;
    }
  }

  static const double minimumScore = .9;
}

TempMailModel _failedModel = TempMailModel(
  mail: 'mail',
  score: 0,
  autoCorrect: 'autoCorrect',
  disposal: true,
  deliverable: false,
);
