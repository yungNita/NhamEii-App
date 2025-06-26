import 'package:flutter/foundation.dart';

class FoodItem {
  final String id;
  final String imageUrl;
  final String title;
  final String price;
  final String? detail;
  final String? rating;
  bool isWishlisted;

  FoodItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.detail,
    this.rating,
    this.isWishlisted = false,
  });

  FoodItem copyWith({
    bool? isWishlisted,
  }) {
    return FoodItem(
      id: id,
      imageUrl: imageUrl,
      title: title,
      price: price,
      detail: detail,
      rating: rating,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }
}

class WishlistProvider with ChangeNotifier {
  final List<FoodItem> _wishlistItems = [];

  List<FoodItem> get wishlistItems => _wishlistItems;

  void toggleWishlist(FoodItem item) {
    if (_wishlistItems.any((element) => element.id == item.id)) {
      _wishlistItems.removeWhere((element) => element.id == item.id);
    } else {
      _wishlistItems.add(item.copyWith(isWishlisted: true));
    }
    notifyListeners();
  }
}