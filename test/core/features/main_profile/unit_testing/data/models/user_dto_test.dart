import 'package:flowery_tracking_app/features/orders_page/data/models/user_dto.dart';
import 'package:test/test.dart';

void main() {
  test("test UserDto to UserDtoEntity", () {
    // Arrange
    final userDto = UserDto(
      id: "id",
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      gender: "gender",
      phone: "phone",
      photo: "photo",
      passwordChangedAt: "passwordChangedAt",
    );

    // Act
    final result = userDto.toEntity();

    // Assert
    expect(result.id, equals(userDto.id));
    expect(result.firstName, equals(userDto.firstName));
    expect(result.lastName, equals(userDto.lastName));
    expect(result.email, equals(userDto.email));
    expect(result.gender, equals(userDto.gender));
    expect(result.phone, equals(userDto.phone));
    expect(result.photo, equals(userDto.photo));
    expect(result.passwordChangedAt, equals(userDto.passwordChangedAt));
  });
}
