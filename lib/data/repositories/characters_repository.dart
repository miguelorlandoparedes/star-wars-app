import 'package:desafio_entrevista/data/models/page_response_model.dart';

abstract class CharactersRepository {
  Future<PageResponseModel> fetch(int? page);
  Future<PageResponseModel> search(String query, int? page);
}
