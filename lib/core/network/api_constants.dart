abstract class ApiConstants {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1/";
  static const String features = "features";
  static const String geometry = "geometry";
  static const String coordinates = "coordinates";
  static const String mapUrl =
      "https://api.openrouteservice.org/v2/directions/driving-car?api_key=";
  static const String ordersState = "orders/state/{id}";
  static const String state = "state";
  static const String changePassword = "drivers/change-password";
  static const String getAllDriverOrders = "orders/driver-orders";
  static const String gemeniBaseUrl =
      "https://generativelanguage.googleapis.com/v1";
  static const String applyDriver = 'drivers/apply';
  static const String getAllVehicles = 'vehicles';
  static const checkPhoto = '/models/gemini-2.5-flash:generateContent';
  static const String login = "drivers/signin";
  static const String forgotPassword = "forgotPassword";
  static const String verifyResetCode = "verifyResetCode";
  static const String resetPassword = "resetPassword";
  static const String mainProfile = "drivers/profile-data";
  static const String getVehicle = "vehicles";
  static const String logout = "drivers/logout";
}
