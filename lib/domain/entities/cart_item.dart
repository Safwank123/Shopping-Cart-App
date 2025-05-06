import 'package:flutter/material.dart';
import 'package:shopping_cart_app/domain/entities/product.dart';

@immutable
class CartItem {
  final int productId;
  final String title;
  final double price;
  final int quantity;
  final String variant;
  final String imageUrl;

  const CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.variant,
    required this.imageUrl,
  });

  // Convert to Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'variant': variant,
      'imageUrl': imageUrl,
    };
  }

  // Create from Map for SQLite retrieval
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] as int,
      title: map['title'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      variant: map['variant'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  // Helper method to create from Product
  factory CartItem.fromProduct(Product product, {String variant = 'Default'}) {
    return CartItem(
      productId: product.id,
      title: product.title,
      price: product.price,
      quantity: 1,
      variant: variant,
      imageUrl: product.thumbnail,
    );
  }

  // For immutable updates
  CartItem copyWith({
    int? productId,
    String? title,
    double? price,
    int? quantity,
    String? variant,
    String? imageUrl,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      variant: variant ?? this.variant,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // Calculate total price for this item
  double get total => price * quantity;

  // Equality checks
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.productId == productId &&
        other.title == title &&
        other.price == price &&
        other.quantity == quantity &&
        other.variant == variant &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      productId,
      title,
      price,
      quantity,
      variant,
      imageUrl,
    );
  }

  // For debugging
  @override
  String toString() {
    return 'CartItem('
        'productId: $productId, '
        'title: "$title", '
        'price: \$$price, '
        'quantity: $quantity, '
        'variant: "$variant", '
        'imageUrl: "$imageUrl")';
  }
}