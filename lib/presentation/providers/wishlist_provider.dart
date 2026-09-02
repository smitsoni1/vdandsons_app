import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<String> _wishlistIds = [];
  final String _key = 'wishlist_items';

  List<String> get wishlistIds => _wishlistIds;

  WishlistProvider() {
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    _wishlistIds = prefs.getStringList(_key) ?? [];
    notifyListeners();
  }

  Future<void> toggleWishlist(Product product) async {
    if (_wishlistIds.contains(product.id)) {
      _wishlistIds.remove(product.id);
    } else {
      _wishlistIds.add(product.id);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _wishlistIds);
    notifyListeners();
  }

  bool isInWishlist(String productId) {
    return _wishlistIds.contains(productId);
  }
}
