import 'package:firebase_chat/features/search/presentation/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/auth/presentation/providers/user_provider.dart';
import '../features/email_verification/presentation/providers/email_verification_provider.dart';
import '../features/theming/providers/theme_provider.dart';

class ProvidersInit {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => EVerifyProvider()),
    ChangeNotifierProvider(create: (context) => SearchProvider()),
  ];
}
