class Property {
  final String city;
  final String propertyType;
  final int parkingSpaces;
  final int bedrooms;
  final int bathrooms;
  final int servantQuarters;
  final int kitchens;
  final int storeRooms;
  final double price;
  final String agePossession;
  final double area;
  final String colony;
  final String province;

  Property({
    required this.city,
    required this.propertyType,
    required this.parkingSpaces,
    required this.bedrooms,
    required this.bathrooms,
    required this.servantQuarters,
    required this.kitchens,
    required this.storeRooms,
    required this.price,
    required this.agePossession,
    required this.area,
    required this.colony,
    required this.province,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      city: json['City'],
      propertyType: json['property_type'],
      parkingSpaces: json['parking_spaces'],
      bedrooms: json['Bedrooms'],
      bathrooms: json['Bathrooms'],
      servantQuarters: json['servant_Quarters'],
      kitchens: json['Kitchens'],
      storeRooms: json['store_rooms'],
      price: (json['price'] as num).toDouble(),
      agePossession: json['age_possession'],
      area: (json['area'] as num).toDouble(),
      colony: json['colony'],
      province: json['province'],
    );
  }
}
