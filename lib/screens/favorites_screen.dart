import 'package:desafio_entrevista/data/models/character_model.dart';
import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/cards_list.dart';
import 'package:desafio_entrevista/widgets/cards/character_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
      CharactersProvider,
      ({
        List<CharacterModel> favoriteCharacters,
        ScrollController scrollController,
      })
    >(
      selector: (context, provider) => (
        favoriteCharacters: provider.favoriteCharacters,
        scrollController: provider.scrollController,
      ),
      builder: (context, state, _) {
        return CardsList(
          characters: state.favoriteCharacters
              .map((c) => CharacterCard(key: ValueKey(c.url), character: c))
              .toList(),
          scrollController: null,
        );
      },
    );
  }
}
