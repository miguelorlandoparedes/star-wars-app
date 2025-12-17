import 'package:desafio_entrevista/data/models/character_model.dart';
import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/widgets/cards/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 420),

      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  character.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                _FavoriteButton(character: character),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              '${character.gender} - ${character.birthYear}',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const Divider(height: 20),
            GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 40,
              ),
              shrinkWrap: true,
              children: [
                _InfoRow(
                  label: 'Height',
                  value: character.height,
                  icon: Icons.height,
                ),
                _InfoRow(
                  label: 'Mass',
                  value: character.mass,
                  icon: Icons.balance,
                ),
                _InfoRow(
                  label: 'Hair',
                  value: character.hairColor,
                  icon: Icons.face,
                ),
                _InfoRow(
                  label: 'Eyes',
                  value: character.eyeColor,
                  icon: Icons.remove_red_eye_outlined,
                ),
                _InfoRow(
                  label: 'Skin',
                  value: character.skinColor,
                  icon: Icons.person_2_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Selector<CharactersProvider, bool>(
      selector: (_, provider) => provider.isFavorite(character),
      builder: (context, isFavorite, _) {
        return IconButton(
          onPressed: () {
            context.read<CharactersProvider>().toggleFavorite(character);
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(isFavorite),
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
