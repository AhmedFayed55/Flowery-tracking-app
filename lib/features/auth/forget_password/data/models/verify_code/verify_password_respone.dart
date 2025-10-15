class VerifyPasswordRespone {
  String? status;

  VerifyPasswordRespone({this.status});

  factory VerifyPasswordRespone.fromJson(Map<String, dynamic> json) {
    return VerifyPasswordRespone(status: json['status'] as String?);
  }

  Map<String, dynamic> toJson() => {'status': status};
}
