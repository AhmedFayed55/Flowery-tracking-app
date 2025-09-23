class VerifyPasswordBody {
  String? resetCode;

  VerifyPasswordBody({this.resetCode});

  factory VerifyPasswordBody.fromJson(Map<String, dynamic> json) {
    return VerifyPasswordBody(resetCode: json['resetCode'] as String?);
  }

  Map<String, dynamic> toJson() => {'resetCode': resetCode};
}
