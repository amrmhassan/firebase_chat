import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class FirebaseInit {
  static Future<FirebaseApp> init() async {
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
