class DBCollections {
  static const String users = 'users';
  static const String rooms = 'rooms';

  static String getRef(List<String> collections) {
    return collections.join('/');
  }
}
