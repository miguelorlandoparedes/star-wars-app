import 'package:flutter/material.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(Icons.search),
      iconSize: 40,
      padding: EdgeInsets.all(18),
      // color: Colors.white,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry geometry) {
    final xPosition =
        (geometry.scaffoldSize.width -
            geometry.floatingActionButtonSize.width) /
        2;

    final yPosition =
        geometry.scaffoldSize.height -
        72 -
        (geometry.floatingActionButtonSize.height / 2.6);

    return Offset(xPosition, yPosition);
  }
}
