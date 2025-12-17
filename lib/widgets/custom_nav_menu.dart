import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavMenu extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomNavMenu({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CharactersProvider>();

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      surfaceTintColor: Colors.transparent,
      title: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Image.asset(
                'assets/images/star_wars_logo_no_bg.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              Spacer(),
              _NavButton(
                label: 'Characters',
                selected: currentIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              _NavButton(
                label: 'Favorites',
                selected: currentIndex == 1,
                onTap: () => onTabSelected(1),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: provider.searchController,
                  onChanged: provider.onQueryChanged,
                  decoration: InputDecoration(
                    hintText: 'Search characters',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 0,
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected
        ? theme.textTheme.titleMedium?.color
        : theme.textTheme.titleMedium?.color?.withOpacity(0.6);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: selected ? 20 : 0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
