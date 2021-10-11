import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;
  const GroceryListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the list of grocery items from the manager
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = groceryItems[index];

          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              // print('SnackBar Dismissed');
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} Deleted')));
            },

            /// [InkWell] provides animated ripple feedback.
            /// For example, when the user taps a UI element you
            /// use it to display a splash screen
            child: InkWell(
              // Wrap GroceryTile inside InkWell
              child: GroceryTile(
                  item: item,
                  key: Key(item.id),
                  onComplete: (change) {
                    if (change != null) {
                      manager.completeItem(index, change);
                    }
                  }),

              /// When the gesture recognizes a tap,
              /// it presents [GroceryItemScreen],
              /// letting the user edit the current item
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => GroceryItemScreen(
                      originalItem: item,

                      /// This [onCreate] won't be called since the user
                      ///  updating an existing item
                      onCreate: (item) {},

                      /// Call onUpdate when the user updates an item
                      onUpdate: (item) {
                        /// update the item at the particular index
                        manager.updateItem(item, index);

                        /// Dismis the Window list [GroceryItemScreen]
                        /// Will throw the an update field window
                        /// Note that! This gives a blank so we don't
                        /// use navigator pop to remove the window
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          );

          /// For each item in the list,
          /// get the current item and construct a [GroceryTile]
          // return GroceryTile(
          //   key: Key(item.id),
          //   item: item,
          //   // return on complete when the user taps the checkbox
          //   onComplete: (change) {
          //     // Change if there is a change and update,
          //     // the item's isComplete status
          //     if (change != null) {
          //       manager.completeItem(index, change);
          //     }
          //   },
          // );
        },
        // Make space of each grocery item 16 pixels apart
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
        itemCount: groceryItems.length,
      ),
    );
  }
}
