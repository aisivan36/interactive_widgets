import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  /// [onCreate] is a callback it lets us know  when a new item is created.
  final Function(GroceryItem) onCreate;

  /// [onUpdate] is a callback it returns the updated grocery item.
  final Function(GroceryItem) onUpdate;

  /// The grocery item that  the user clicked
  final GroceryItem? originalItem;

  /// [isUpdating] determines whether the user is creating or editing an item -
  final bool isUpdating;

  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  // TODO Add grocery item screen state properties

  @override
  Widget build(BuildContext context) {
    // TODO add groceryitemscreen scafold
    return Container(
      color: Colors.orange,
    );
    // TODO: Add buildNameField()
// TODO: Add buildImportanceField()
// TODO: ADD buildDateField()
// TODO: Add buildTimeField()
// TODO: Add buildColorPicker()
// TODO: Add buildQuantityField()
  }
}