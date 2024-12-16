class Restaurant {
  final int? id;
  final String name;
  final String category;
  final String address;
  final double rating;
  final bool hasSingleTable;
  final bool hasWifi;
  final bool hasSocket;
  final String openingHours;
  final String? imageUrl;

  Restaurant({
    this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.rating,
    required this.hasSingleTable,
    required this.hasWifi,
    required this.hasSocket,
    required this.openingHours,
    this.imageUrl,
  });

  // JSON 변환을 위한 메서드
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'address': address,
      'rating': rating,
      'hasSingleTable': hasSingleTable ? 1 : 0,
      'hasWifi': hasWifi ? 1 : 0,
      'hasSocket': hasSocket ? 1 : 0,
      'openingHours': openingHours,
      'imageUrl': imageUrl,
    };
  }

  // Map에서 객체 생성
  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      address: map['address'],
      rating: map['rating'],
      hasSingleTable: map['hasSingleTable'] == 1,
      hasWifi: map['hasWifi'] == 1,
      hasSocket: map['hasSocket'] == 1,
      openingHours: map['openingHours'],
      imageUrl: map['imageUrl'],
    );
  }
}
