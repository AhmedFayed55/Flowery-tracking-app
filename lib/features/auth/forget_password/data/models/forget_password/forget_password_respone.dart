class ForgetPasswordRespone {
  String? message;
  String? info;

  ForgetPasswordRespone({this.message, this.info});

  factory ForgetPasswordRespone.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRespone(
      message: json['message'] as String?,
      info: json['info'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'message': message, 'info': info};
}
