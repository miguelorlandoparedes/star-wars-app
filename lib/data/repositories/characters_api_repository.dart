import 'package:desafio_entrevista/data/api/characters_api.dart';
import 'package:desafio_entrevista/data/models/page_response_model.dart';
import 'package:desafio_entrevista/data/repositories/characters_repository.dart';

class CharactersApiRepository extends CharactersRepository {
  final CharactersApi api;

  CharactersApiRepository(this.api);

  @override
  Future<PageResponseModel> fetch(int? page) {
    return api.fetch(page);
  }

  @override
  Future<PageResponseModel> search(String query, int? page) {
    return api.search(query, page);
  }
}
