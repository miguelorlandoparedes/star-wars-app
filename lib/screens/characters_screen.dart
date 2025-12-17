import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/characters_view.dart';
import 'package:desafio_entrevista/widgets/cards/characters_view_skeleton.dart';
import 'package:desafio_entrevista/widgets/cards/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharactersProvider>(context, listen: false).loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (context, provider, _) {
        if (provider.error != null) {
          return Center(
            child: CustomCard(
              child: Text(
                'We couldn’t load the data right now. Try again later.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
        }

        if (provider.isLoading && provider.characters.isEmpty) {
          return CharactersViewSkeleton();
        }

        return CharactersView();
      },
    );
  }
}
