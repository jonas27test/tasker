

class User {
  String email;
  String password;

  User(String email, String password) {
    this.email = email;
    this.password = password;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getEmail() {
    return this.email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getPassword() {
    return password;
  }

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}