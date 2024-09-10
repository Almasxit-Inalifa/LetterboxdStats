import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final String selectedWidget;
  final ValueChanged<String?> onWidgetChanged;

  const DropDown({
    super.key,
    required this.selectedWidget,
    required this.onWidgetChanged,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return DropdownButton<String>(
      value: selectedWidget,
      dropdownColor: theme.appBarTheme.backgroundColor,
      iconEnabledColor: Colors.white,
      focusColor: Colors.transparent,
      style: const TextStyle(color: Colors.white),
      items: const [
        DropdownMenuItem(
          value: 'Most Watched',
          child: Text('Most Watched'),
        ),
        DropdownMenuItem(
          value: 'Highest Rated',
          child: Text('Highest Rated'),
        ),
      ],
      onChanged: onWidgetChanged,
    );
  }
}
