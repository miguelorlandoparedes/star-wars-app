import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/utils/layout.dart';
import 'package:desafio_entrevista/widgets/app_bar/desktop_app_bar_content.dart';
import 'package:desafio_entrevista/widgets/app_bar/mobile_app_bar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.onTabSelected,
    required this.currentIndex,
  });

  final int currentIndex;
  final void Function(int) onTabSelected;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = LayoutUtils.isDesktopLayout(constraints);

        if (isDesktop) {
          return AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            surfaceTintColor: Colors.transparent,
            title: DesktopAppBarContent(
              currentIndex: currentIndex,
              onTabSelected: onTabSelected,
            ),
          );
        }

        return Selector<CharactersProvider, bool>(
          selector: (context, provider) => provider.isSearching,
          builder: (context, isSearching, _) {
            return AppBar(
              surfaceTintColor: Colors.transparent,
              title: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: MobileAppBarContent(),
              ),
              actions: [
                if (isSearching)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: context.read<CharactersProvider>().stopSearch,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
