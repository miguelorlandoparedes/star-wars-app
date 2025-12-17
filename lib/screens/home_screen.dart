import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/screens/characters_screen.dart';
import 'package:desafio_entrevista/screens/favorites_screen.dart';
import 'package:desafio_entrevista/widgets/custom_bottom_nav_bar.dart';
import 'package:desafio_entrevista/widgets/custom_nav_menu.dart';
import 'package:desafio_entrevista/widgets/custom_search_button.dart';
import 'package:desafio_entrevista/widgets/mobile_app_bar.dart';
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

  bool _isDesktop(BoxConstraints constraints) {
    return constraints.maxWidth >= 900;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = _isDesktop(constraints);
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
                    onSearch: () {},
                    onTabSelected: _onTabSelected,
                  )
                : Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 40),
                    child: _pages[_selectedIndex],
                  ),
            appBar: isDesktop ? null : MobileAppBar(),
            bottomNavigationBar: isDesktop
                ? null
                : CustomBottomNavBar(
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
            // : FloatingActionButtonLocation.centerDocked,
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
    required this.onSearch,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final List<Widget> pages;
  final VoidCallback onSearch;
  final void Function(int) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomNavMenu(
          currentIndex: selectedIndex,
          onTabSelected: onTabSelected,
        ),
        Expanded(
          child: Consumer<CharactersProvider>(
            builder: (context, provider, _) {
              return provider.scrollController.hasClients
                  ? Scrollbar(
                      controller: provider.scrollController,
                      thumbVisibility: true,
                      child: pages[selectedIndex],
                    )
                  : pages[selectedIndex];
            },
          ),
        ),
      ],
    );
  }
}
