import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/cards_view.dart';
import 'package:desafio_entrevista/widgets/cards/character_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (context, provider, _) {
        return CardsView(
          characters: provider.characters
              .map((c) => CharacterCard(character: c))
              .toList(),
          scrollController: provider.scrollController,
        );
      },
    );
  }
}
