class _SignProvidersConstants {
  static const String email = 'password';
  static const String google = 'google.com';
  static const String facebook = 'facebook.com';
}

class SignProvidersGet {
  static SignProvider? get(String provider) {
    if (provider == _SignProvidersConstants.google) {
      return SignProvider.google;
    } else if (provider == _SignProvidersConstants.facebook) {
      return SignProvider.facebook;
    } else if (provider == _SignProvidersConstants.email) {
      return SignProvider.email;
    }
    return null;
  }
}

enum SignProvider {
  email,
  google,
  facebook,
}
