import 'package:flutter/material.dart';

///[TabManager] extends [ChangeNotifier].
///This allows the object to provide change
///notifications to its listeners.
class TabManager extends ChangeNotifier {
  /// [selectedTab] keeps track of which tab the user is tapped.
  int selectedTab = 0;

  // ignore: lines_longer_than_80_chars
  /// The [goToTab] is simple function that can modify the current selectedTab index
  void goToTab(index) {
    selectedTab = index;
    notifyListeners(); // To notify all widgets listening to this state.
  }

  /// The [goToRecipes] is a specific function that sets selectedTab to the
  ///  recipes tab, which is at index 1.
  void goToRecipes() {
    selectedTab = 1;
    notifyListeners(); // To notify all widgets listening to this state.
  }
}
