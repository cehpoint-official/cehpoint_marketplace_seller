class AvatarUrl {
  static String avatarUrl = "";
  static String username = "";

  static void setUsername(String user) {
    username = user;
  }

  static String fetchUsername() {
    return username;
  }

  static void set(String url) {
    avatarUrl = url;
  }

  static String fetch() {
    return avatarUrl;
  }
}
