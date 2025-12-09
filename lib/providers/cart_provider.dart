import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, int> _items = {};

  // قائمة الطعام
  final List<FoodItem> _availableFood = [
    FoodItem(
      id: '1',
      name: 'برجر لحم كلاسيك',
      description: 'شريحة لحم بقري مشوي مع جبنة شيدر وخس وطماطم وصوص خاص.',
      price: 25.0,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80',
    ),
    FoodItem(
      id: '2',
      name: 'بيتزا بيبروني',
      description: 'عجينة رقيقة مع صوص طماطم وجبنة موزاريلا وشرائح بيبروني.',
      price: 35.0,
      imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?auto=format&fit=crop&w=800&q=80',
    ),
    FoodItem(
      id: '3',
      name: 'سوشي كاليفورنيا',
      description: 'رولات سوشي طازجة مع السلطعون والأفوكادو والخيار.',
      price: 45.0,
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=800&q=80',
    ),
    FoodItem(
      id: '4',
      name: 'باستا ألفريدو',
      description: 'مكرونة فيتوتشيني مع صوص الكريمة البيضاء والدجاج والفطر.',
      price: 30.0,
      imageUrl: 'https://images.unsplash.com/photo-1645112411341-6c4fd023714a?auto=format&fit=crop&w=800&q=80',
    ),
    FoodItem(
      id: '5',
      name: 'سلطة سيزر',
      description: 'خس روماني مقرمش مع قطع دجاج مشوية وجبنة بارميزان.',
      price: 20.0,
      imageUrl: 'https://images.unsplash.com/photo-1550304999-8faf70dd4ad9?auto=format&fit=crop&w=800&q=80',
    ),
    FoodItem(
      id: '6',
      name: 'عصير برتقال',
      description: 'عصير برتقال طبيعي طازج بدون سكر.',
      price: 10.0,
      imageUrl: 'https://images.unsplash.com/photo-1613478223719-2ab802602423?auto=format&fit=crop&w=800&q=80',
    ),
  ];

  List<FoodItem> get foodItems => _availableFood;
  int get itemCount => _items.length;
  Map<String, int> get cartItems => _items;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, quantity) {
      final product = _availableFood.firstWhere((element) => element.id == key);
      total += product.price * quantity;
    });
    return total;
  }

  void addItem(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existing) => existing + 1);
    } else {
      _items.putIfAbsent(productId, () => 1);
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]! > 1) {
      _items.update(productId, (existing) => existing - 1);
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  FoodItem findById(String id) {
    return _availableFood.firstWhere((element) => element.id == id);
  }
}