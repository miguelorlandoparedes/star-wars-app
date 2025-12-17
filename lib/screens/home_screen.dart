import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/screens/characters_screen.dart';
import 'package:desafio_entrevista/screens/favorites_screen.dart';
import 'package:desafio_entrevista/utils/custom_fab_location.dart';
import 'package:desafio_entrevista/utils/layout.dart';
import 'package:desafio_entrevista/widgets/app_bar/custom_app_bar.dart';
import 'package:desafio_entrevista/widgets/bottom_app_bar/custom_bottom_app_bar.dart';
import 'package:desafio_entrevista/widgets/bottom_app_bar/custom_search_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = const <Widget>[CharactersScreen(), FavoritesScreen()];

  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = LayoutUtils.isDesktopLayout(constraints);
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/stars_bg.png'),
              fit: BoxFit.cover,
            ),
          ),

          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: isDesktop
                ? _DesktopPageContainer(
                    selectedIndex: _selectedIndex,
                    pages: _pages,
                  )
                : Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 40),
                    child: _pages[_selectedIndex],
                  ),
            appBar: CustomAppBar(
              currentIndex: _selectedIndex,
              onTabSelected: _onTabSelected,
            ),
            bottomNavigationBar: isDesktop
                ? null
                : CustomBottomAppBar(
                    onTap: _onTabSelected,
                    selectedIndex: _selectedIndex,
                  ),
            floatingActionButton: isDesktop
                ? null
                : CustomSearchButton(
                    onPressed: () {
                      context.read<CharactersProvider>().startSearch();
                    },
                  ),
            floatingActionButtonLocation: isDesktop
                ? null
                : CustomFloatingActionButtonLocation(),
          ),
        );
      },
    );
  }
}

class _DesktopPageContainer extends StatelessWidget {
  const _DesktopPageContainer({
    required this.selectedIndex,
    required this.pages,
  });

  final int selectedIndex;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return Selector<
      CharactersProvider,
      ({ScrollController controller, int favoritesCount})
    >(
      selector: (context, provider) => (
        controller: provider.scrollController,
        favoritesCount: provider.favoriteCharacters.length,
      ),
      builder: (context, state, _) {
        final scrollController = state.controller;
        final favoritesCount = state.favoritesCount;

        final isEmptyFavoritesPage = selectedIndex == 1 && favoritesCount == 0;

        final shouldWrapWithScrollbar =
            scrollController.hasClients && !isEmptyFavoritesPage;

        return shouldWrapWithScrollbar
            ? Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: pages[selectedIndex],
              )
            : pages[selectedIndex];
      },
    );
  }
}
