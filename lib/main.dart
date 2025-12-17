import 'package:desafio_entrevista/app.dart';
import 'package:desafio_entrevista/config/app_config.dart';
import 'package:desafio_entrevista/data/api/characters_api.dart';
import 'package:desafio_entrevista/data/repositories/characters_api_repository.dart';
import 'package:desafio_entrevista/data/repositories/characters_mock_repository.dart';
import 'package:desafio_entrevista/data/repositories/characters_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final CharactersRepository charactersRepository = AppConfig.useMockData
      ? CharactersMockRepository()
      : CharactersApiRepository(CharactersApi(http.Client()));

  runApp(StarWarsApp(charactersRepository: charactersRepository));
}
