class FoodItem {
  final String name;
  final String imageUrl;
  final String price;
  final String? description;
  final String? rating;

  FoodItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.description,
    this.rating,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      description: json['description'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'description': description,
        'rating': rating,
      };
}
