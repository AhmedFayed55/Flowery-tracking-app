class StoreEntity {
  StoreEntity({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  String? name;
  String? image;
  String? address;
  String? phoneNumber;
  String? latLong;

  StoreEntity.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    latLong = json['latLong'];
  }
}
