import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/character_card_skeleton.dart';
import 'package:desafio_entrevista/widgets/cards/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsList extends StatelessWidget {
  const CardsList({
    super.key,
    required this.characters,
    required this.scrollController,
  });

  final List<Widget> characters;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (characters.isEmpty) {
          return Center(
            child: CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'No characters found.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          );
        }

        if (constraints.maxWidth >= 680) {
          return GridView.builder(
            primary: false,
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: (constraints.maxWidth - 1200) > 0
                  ? (constraints.maxWidth - 1200) / 2
                  : 12,
            ),

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 200,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount:
                characters.length +
                (context.watch<CharactersProvider>().isLoading ? 4 : 0),
            itemBuilder: (context, index) {
              if (index >= characters.length) {
                return CharacterCardSkeleton();
              }

              return characters[index];
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          itemCount:
              characters.length +
              (context.watch<CharactersProvider>().isLoading ? 2 : 0),
          itemBuilder: (context, index) {
            if (index >= characters.length) {
              return Align(
                key: characters[index].key,
                alignment: Alignment.topCenter,
                child: CharacterCardSkeleton(),
              );
            }
            return Align(
              key: characters[index].key,
              alignment: Alignment.topCenter,
              child: characters[index],
            );
          },
        );
      },
    );
  }
}
