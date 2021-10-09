import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'empty_grocery_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// floatingActionButton
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          /// TODO Present GroceryItemScreen
        },
      ),
      body: buildGroceryScreen(), // Show the buildGroceryScreen
    );
  }

  /// [buildGroceryScreen()] is a helper function that decides which widget tree
  /// to construct. Here’s how it works:
  /// 1 We wrap our widgets inside a Consumer,
  ///  which listens for [GroceryManager] state changes.
  /// 2 Consumer rebuilds the widgets below itself when the grocery -
  /// items changes.
  /// 3 If there are grocery items in the list, show the [GroceryListScreen].
  /// 4 If there are no grocery items, show the [EmptyGroceryScreen].
  ///  ====================== [Note that] ======================================
  /// We should only wrap a Consumer around widgets that need it.
  /// For example, wrapping a consumer widgets at the top level would force it -
  /// to rebuild the entire tree!.
  Widget buildGroceryScreen() {
    return Consumer<GroceryManager>(builder: (context, manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        //TODO Add groceryListScreen
        return Container();
      } else {
        return const EmptyGroceryScreen();
      }
    });
  }
}
