import 'package:desafio_entrevista/data/api/mock_data.dart';
import 'package:desafio_entrevista/data/models/page_response_model.dart';
import 'package:desafio_entrevista/data/repositories/characters_repository.dart';

class CharactersMockRepository implements CharactersRepository {
  CharactersMockRepository();

  @override
  Future<PageResponseModel> fetch(int? page) async {
    await Future.delayed(const Duration(seconds: 2));
    return PageResponseModel.fromRawJson(MockData.mockPageResponseModel);
  }

  @override
  Future<PageResponseModel> search(String query, int? page) async {
    final response = await fetch(page);

    if (query.isEmpty) return response;

    final filteredResults = response.results
        .where(
          (character) =>
              character.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    response.results.clear();
    response.results.addAll(filteredResults);

    return response;
  }
}
