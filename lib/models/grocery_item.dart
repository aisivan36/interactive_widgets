import 'package:flutter/painting.dart';

enum Importance {
  low,
  medium,
  high,
}

class GroceryItem {
  final String id;
  final String name;
  final Importance importance;
  final Color color;
  final int quantity;
  final DateTime date;
  final bool isComplete;

  GroceryItem({
    required this.id,
    required this.name,
    required this.importance,
    required this.color,
    required this.date,
    this.isComplete = false, // is complete default value is false
    required this.quantity,
  });

  GroceryItem copyWith({
    String? id,
    String? name,
    Importance? importance,
    Color? color,
    int? quantity,
    DateTime? date,
    bool? isComplete,
  }) {
    return GroceryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        importance: importance ?? this.importance,
        date: date ?? this.date,
        isComplete: isComplete ?? this.isComplete,
        quantity: quantity ?? this.quantity);
  }
}
