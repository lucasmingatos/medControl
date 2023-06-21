class Routes {
  static const String authService =
      "https://identitytoolkit.googleapis.com/v1/";

  static const String apiKey = "AIzaSyBy_sRP_4QJFxd_gMCV5uySkKs2_wh-Sfw";

  String signIn() {
    // ignore: prefer_interpolation_to_compose_strings
    return authService + "accounts:signInWithPassword?key=" + apiKey;
  }

  String signUp() {
    // ignore: prefer_interpolation_to_compose_strings
    return authService + "accounts:signUp?key=" + apiKey;
  }
}
