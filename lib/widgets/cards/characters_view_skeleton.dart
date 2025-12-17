import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/cards_list.dart';
import 'package:desafio_entrevista/widgets/cards/character_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersViewSkeleton extends StatelessWidget {
  const CharactersViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CharactersProvider, ScrollController>(
      selector: (context, provider) => provider.scrollController,
      builder: (context, scrollController, _) {
        return CardsList(
          characters: List.generate(10, (index) => CharacterCardSkeleton()),
          scrollController: scrollController,
        );
      },
    );
  }
}
