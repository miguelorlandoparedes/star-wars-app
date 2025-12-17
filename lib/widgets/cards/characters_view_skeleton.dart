import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/cards_view.dart';
import 'package:desafio_entrevista/widgets/cards/character_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersViewSkeleton extends StatelessWidget {
  const CharactersViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (context, provider, _) {
        return CardsView(
          characters: List.generate(10, (index) => CharacterCardSkeleton()),
          scrollController: provider.scrollController,
        );
      },
    );
  }
}
