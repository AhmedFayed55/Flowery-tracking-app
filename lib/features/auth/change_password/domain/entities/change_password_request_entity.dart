class ChangePasswordRequestEntity {
  String oldPassword;
  String newPassword;
  ChangePasswordRequestEntity({
    required this.oldPassword,
    required this.newPassword,
  });
}
