class TokenResponse {
  String token;

  TokenResponse({this.token});

  TokenResponse.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    return data;
  }
}