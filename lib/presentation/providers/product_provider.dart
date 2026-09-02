import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/services/firebase_service.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await _firebaseService.getProducts();

    _isLoading = false;
    notifyListeners();
  }
}
