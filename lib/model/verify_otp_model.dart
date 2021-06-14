class VerifyLoginOTPModel {
  int otp;

  VerifyLoginOTPModel({this.otp});

  factory VerifyLoginOTPModel.fromJson(Map<String, dynamic> verifyJson) {
    return VerifyLoginOTPModel(otp: verifyJson['otp']);
  }

  Map<String, dynamic> toJSon() => {'otp': otp};
}
