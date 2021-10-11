import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../components/grocery_tile.dart';

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
  /// The [_nameController] is a [TextEditingController].
  /// This controller listens for textchanges.
  ///  It controls the value displayed in a text field.
  final _nameController = TextEditingController();

  /// [_name] stores the name of the item.
  String _name = '';

  /// [_importance] stores the importance level.
  Importance _importance = Importance.low;

  /// [_dueDate] stores the current date and time.
  DateTime _dueDate = DateTime.now();

  /// [_timeOfDay] stores the current time.
  TimeOfDay _timeOfDay = TimeOfDay.now();

  /// [_currentColor] stores the color label.
  Color _currentColor = Colors.green;

  /// [_currentSliderValue] stores the quantity of an item.
  int _currentSliderValue = 0;

  /// Before widget builds, [initState] initializes its properties before use.
  @override
  void initState() {
    /// When the originalItem is not null, the user is editing an existing item.
    /// In this case, we must configure the widget to show the item's values.
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    /// Adds a listener to listen for text field changes. When the text changes,
    /// we set the _name.
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    super.initState();
  }

  /// This will dispose the [TextEditingController] when it no longer need it.
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// [Scafold] defines the main layout and structure of the entire screen.
    return Scaffold(
      /// [Button] includes an app bar with one action [button].
      /// The user will tap this button when they have finished creating an item
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print('tapped');
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
                quantity: _currentSliderValue,
              );

              /// If the use is updating the product, call the onUpdate
              if (widget.isUpdating) {
                widget.onUpdate(groceryItem);
              } else {
                /// otherwise it creates a new one
                widget.onCreate(groceryItem);
              }

              /// Pop off the window will be dismissed
              Navigator.pop(context);
            },

            ///Icon check button
            icon: const Icon(Icons.check),
          ),
        ],

        /// Set [elevation] to [0.0] it removes the shadow under the appbar.
        elevation: 0.0,

        /// [AppBar]'s title
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),

      /// Shows a listview padded by 16 pixels on every side, within the body
      /// of [Scaffold]
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            const SizedBox(height: 10),
            buildColorPicker(context),
            const SizedBox(height: 10),
            buildQuantityField(),
            GroceryTile(
                item: GroceryItem(
                    id: 'previewMode',
                    name: _name,
                    importance: _importance,
                    color: _currentColor,
                    date: DateTime(
                      _dueDate.year,
                      _dueDate.month,
                      _dueDate.day,
                      _timeOfDay.hour,
                      _dueDate.minute,
                    ),
                    quantity: _currentSliderValue)),
          ],
        ),
      ),
    );
  }

  /// Text name Field
  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

  /// Importance's Button
  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.low,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.deepOrangeAccent,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              selectedColor: Colors.red,
              label: const Text(
                'High',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.high,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Date Field
  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
                onPressed: () async {
                  final currentDate = DateTime.now();
                  final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year + 5));
                  setState(() {
                    if (selectedDate != null) {
                      _dueDate = selectedDate;
                    }
                  });
                },
                child: const Text('Select')),
          ],
        ),
        Text('${DateFormat('yyyy-MM-dd').format(_dueDate)}'),
      ],
    );
  }

  /// Time Field
  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time Of Day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
                onPressed: () async {
                  final timeofDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  setState(() {
                    if (timeofDay != null) {
                      _timeOfDay = timeofDay;
                    }
                  });
                },
                child: const Text('Select')),
          ],
        ),
        Text('${_timeOfDay.format(context)}')
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            /// [Container] to display the selected color
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            const SizedBox(height: 9.0),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            /// Dialog Window
            showDialog(
                context: context,
                builder: (context) {
                  /// Wrap the [BlockPicker] inside the [AlertDialog]
                  return AlertDialog(
                    content: BlockPicker(
                      pickerColor: Colors.white,
                      onColorChanged: (color) {
                        setState(() {
                          _currentColor = color; // update the selected color
                        });
                      },
                    ),
                    actions: [
                      /// Button to save color on the pop up window
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                });
          },
          child: const Text('Select'),
        )
      ],
    );
  }

  /// Quantity Field widget
  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            const SizedBox(width: 16.0),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18.0),
            ),
          ],
        ),
        Slider(
            // inactive color with 50% transparent on the right hand
            inactiveColor: _currentColor.withOpacity(0.5),
            // active color with solid color on the left hand
            activeColor: _currentColor,
            // set the current slider value
            value: _currentSliderValue.toDouble(),
            //set min and max value
            min: 0.0,
            max: 100.0,
            // set how we want the slider to increment value
            divisions: 100,
            //the label value that currently selected
            label: _currentSliderValue.toInt().toString(),
            onChanged: (double value) {
              setState(() {
                //update the current slider value
                _currentSliderValue = value.toInt();
              });
            })
      ],
    );
  }
}
