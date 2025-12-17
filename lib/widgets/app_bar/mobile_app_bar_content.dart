import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MobileAppBarContent extends StatelessWidget {
  const MobileAppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CharactersProvider, bool>(
      selector: (_, provider) => provider.isSearching,
      builder: (context, isSearching, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isSearching
              ? TextField(
                  key: const ValueKey('searchField'),
                  controller: context
                      .read<CharactersProvider>()
                      .searchController,
                  autofocus: true,
                  onChanged: context.read<CharactersProvider>().onQueryChanged,
                  decoration: const InputDecoration(
                    hintText: 'Search characters...',
                    border: InputBorder.none,
                  ),
                )
              : Image.asset(
                  key: const ValueKey('logo'),
                  'assets/images/star_wars_logo_no_bg.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
        );
      },
    );
  }
}
