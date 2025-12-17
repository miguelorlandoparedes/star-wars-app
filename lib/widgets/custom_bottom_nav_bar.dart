import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
  });

  final void Function(int) onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      height: 72,
      // color: Colors.blue,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _NavItem(
            icon: Icons.home,
            onPressed: () {
              onTap(0);
            },
            selected: selectedIndex == 0,
          ),
          SizedBox(width: 48),
          _NavItem(
            icon: Icons.favorite,
            onPressed: () {
              onTap(1);
            },
            selected: selectedIndex == 1,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  const _NavItem({
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      iconSize: 32,
      color: selected ? null : Colors.grey,
    );
  }
}
