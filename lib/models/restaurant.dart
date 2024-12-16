class MenuItem {
  final String name;
  final int price;
  final String? imageUrl;

  MenuItem({
    required this.name,
    required this.price,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
}

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
  final List<MenuItem>? menuItems;

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
    this.menuItems,
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
      'menuItems': menuItems?.map((item) => item.toMap()).toList(),
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
      menuItems: map['menuItems'] != null
          ? List<MenuItem>.from(
              map['menuItems']?.map((x) => MenuItem.fromMap(x)))
          : null,
    );
  }
}
