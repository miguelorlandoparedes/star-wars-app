import 'package:flutter/material.dart';

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
