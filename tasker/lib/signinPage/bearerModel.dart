

class BearerToken {
  String bearer;

  BearerToken(String email, String password) {
    this.bearer = email;
  }

  void setBearer(String bearer) {
    this.bearer = bearer;
  }

  String getBearer() {
    return this.bearer;
  }

  BearerToken.fromJson(Map<String, dynamic> json)
      : bearer = json['bearer'];

  Map<String, dynamic> toJson() => {
    'bearer': bearer,
  };
}