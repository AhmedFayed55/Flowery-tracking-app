class UserEntity {
  UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    gender: json["gender"],
    phone: json["phone"],
    photo: json["photo"],
  );
}
