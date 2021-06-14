class LoginData {
  String username;
  String customer_mobile;
  String customer_Password;

  LoginData.data({this.username, this.customer_mobile, this.customer_Password});
  LoginData();

  factory LoginData.fromJson(Map<String, dynamic> loginData) {
    return LoginData.data(
        username: loginData['username'],
        customer_mobile: loginData['customer_mobile'],
        customer_Password: loginData['customer_Password']);
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'customer_mobile': customer_mobile,
        'customer_Password': customer_Password,
      };
}
