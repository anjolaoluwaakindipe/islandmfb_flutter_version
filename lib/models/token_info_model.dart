class TokenInfo {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final int refreshExpiresIn;
  final String sessionsState;
  final String scope;

  const TokenInfo(
      {required this.accessToken,
      required this.expiresIn,
      required this.refreshToken,
      required this.refreshExpiresIn,
      required this.scope,
      required this.sessionsState});

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
        accessToken: json['access_token'],
        expiresIn: json['expires_in'],
        refreshToken: json['refres_token'],
        refreshExpiresIn: json['refresh_expires_in'],
        scope: json["scope"],
        sessionsState: json["session_state"]);
  }
}
