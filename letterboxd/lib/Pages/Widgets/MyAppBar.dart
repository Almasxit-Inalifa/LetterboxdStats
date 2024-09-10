import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String type; // Define type as String
  final Function(int) onTap; // Callback to handle page changes
  final int selectedIndex; // Currently selected index

  const MyAppBar({
    super.key,
    required this.type,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Home',
      'Genres',
      'Themes',
      'Years',
      'Decades',
      'Directors',
      'Actors',
      'Countries',
      'Languages'
    ];
    List<Widget> options = titles.map((title) {
      int index = titles.indexOf(title);
      return TextButton(
        onPressed: () => widget.onTap(index),
        child: Text(
          title,
          style: TextStyle(
            color: widget.selectedIndex == index ? Colors.white : Colors.grey,
          ),
        ),
      );
    }).toList();

    if (widget.type == 'stats') {
      return AppBar(
        actions: [
          Wrap(children: options),
        ],
        foregroundColor: Colors.white,
        toolbarHeight: 100,
      );
    } else {
      return AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: kToolbarHeight,
                child: Image.asset(
                  'lib/assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        foregroundColor: Colors.white,
        toolbarHeight: 100,
      );
    }
  }
}
