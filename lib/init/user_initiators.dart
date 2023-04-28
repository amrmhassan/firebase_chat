import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/init/runtime_variables.dart';

class UserInit {
  static Future<void> reloadUser() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      await user.reload();
    } catch (e) {
      logger.e(e);
    }
  }
}
