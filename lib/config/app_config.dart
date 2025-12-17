import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();

  static final String apiBaseUrl =
      dotenv.env["API_BASE_URL"] ?? "https://swapi.dev/api";
  static final bool useMockData =
      bool.tryParse(dotenv.env["USE_MOCK_DATA"] ?? 'false') ?? false;
}
