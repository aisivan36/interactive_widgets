import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'empty_grocery_screen.dart';
import 'grocery_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// floatingActionButton
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // returns the [GroceryManager] available in the tree.
          final manager = Provider.of<GroceryManager>(context, listen: false);
          // [Navigator.push()] adds a new route to the stack of routes.
          Navigator.push(
            context,

            /// [MaterialPageRoute] replaces entire screen with a
            /// Platform-Specific transition. In Android, for instance,
            /// it slides upwards and fades in,
            /// In iOS it slides in from the right
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                onCreate: (item) {
                  manager.additem(item);
                },
                onUpdate: (item) {},
              ),
            ),
          );
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
