import 'package:desafio_entrevista/data/api/api_constants.dart';
import 'package:desafio_entrevista/data/models/page_response_model.dart';
import 'package:http/http.dart' as http;

class CharactersApi {
  final http.Client client;

  CharactersApi(this.client);

  Future<PageResponseModel> _fetch(String url) async {
    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load characters');
    }

    return PageResponseModel.fromRawJson(response.body);
  }

  Future<PageResponseModel> fetch(int? page) {
    final url = '${ApiConstants.people}${page != null ? "/?page=$page" : ""}';
    return _fetch(url);
  }

  Future<PageResponseModel> search(String query, int? page) {
    final url =
        '${ApiConstants.people}/?search=$query${page != null ? "&page=$page" : ""}';
    return _fetch(url);
  }
}
