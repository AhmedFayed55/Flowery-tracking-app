class ShippingAddressEntity {
  String? street;
  String? city;
  String? phone;
  String? lat;
  String? long;
  ShippingAddressEntity({
    this.street,
    this.city,
    this.phone,
    this.lat,
    this.long,
  });
  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "phone": phone,
    "lat": lat,
    "long": long,
  };
}
