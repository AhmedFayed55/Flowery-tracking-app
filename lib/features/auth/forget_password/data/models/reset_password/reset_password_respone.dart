class ResetPasswordRespone {
  String? message;
  String? token;

  ResetPasswordRespone({this.message, this.token});

  factory ResetPasswordRespone.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRespone(
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'message': message, 'token': token};
}
