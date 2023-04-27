class SignProvidersConstants {
  static const String email = 'password';
  static const String google = 'google.com';
  static const String facebook = 'facebook.com';
}

class SignProvidersGet {
  static SignProvider? get(String provider) {
    if (provider == SignProvidersConstants.google) {
      return SignProvider.google;
    } else if (provider == SignProvidersConstants.facebook) {
      return SignProvider.facebook;
    } else if (provider == SignProvidersConstants.email) {
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
