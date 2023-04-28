import 'package:http/http.dart' as http;
import 'dart:convert';

class FbPhotoTransformer {
  static Future<String?> getPhotoUrl(
    String? accessToken,
    String? providerId, [
    FbPhotoSize size = FbPhotoSize.large,
  ]) async {
    if (providerId == null || accessToken == null) return null;
    try {
      String sizeString = _getPhotoSize(size);
      String photoSource =
          'https://graph.facebook.com/$providerId/picture?type=$sizeString&redirect=false&access_token=$accessToken';
      var res = await http.get(Uri.parse(photoSource));
      var body = json.decode(res.body);
      String url = body['data']['url'];
      return url;
    } catch (e) {
      return null;
    }
  }

  static String _getPhotoSize(FbPhotoSize size) {
    return size.name;
  }
}

enum FbPhotoSize {
  square,
  small,
  normal,
  large,
}
