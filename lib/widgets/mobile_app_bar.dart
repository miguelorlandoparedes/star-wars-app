import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CharactersProvider>();

    return AppBar(
      surfaceTintColor: Colors.transparent,

      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: provider.isSearching
            ? TextField(
                controller: provider.searchController,
                autofocus: true,
                onChanged: provider.onQueryChanged,
                decoration: const InputDecoration(
                  hintText: 'Search characters...',
                  border: InputBorder.none,
                ),
              )
            : Image.asset(
                'assets/images/star_wars_logo_no_bg.png',
                fit: BoxFit.contain,
                height: 40,
              ),
      ),
      actions: [
        if (provider.isSearching)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: provider.stopSearch,
          ),
      ],
    );
  }
}
