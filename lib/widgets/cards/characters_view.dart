import 'package:desafio_entrevista/data/models/character_model.dart';
import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/cards_list.dart';
import 'package:desafio_entrevista/widgets/cards/character_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<
      CharactersProvider,
      ({List<CharacterModel> characters, ScrollController scrollController})
    >(
      selector: (context, provider) => (
        characters: provider.characters.toList(),
        scrollController: provider.scrollController,
      ),
      builder: (context, state, _) {
        return CardsList(
          characters: state.characters
              .map((c) => CharacterCard(character: c))
              .toList(),
          scrollController: state.scrollController,
        );
      },
    );
  }
}
