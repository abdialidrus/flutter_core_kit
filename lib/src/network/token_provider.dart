abstract class TokenProvider {
  Future<String?> fetchToken();
  void onTokenExpired();
}
