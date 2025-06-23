class FoodItem {
  final String name;
  final String imageUrl;
  final String price;

  FoodItem({
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
      };
}
