class ResetPasswordBody {
  String? email;
  String? newPassword;

  ResetPasswordBody({this.email, this.newPassword});

  factory ResetPasswordBody.fromJson(Map<String, dynamic> json) {
    return ResetPasswordBody(
      email: json['email'] as String?,
      newPassword: json['newPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'email': email, 'newPassword': newPassword};
}
