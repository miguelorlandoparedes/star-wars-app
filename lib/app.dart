import 'package:desafio_entrevista/data/repositories/characters_repository.dart';
import 'package:desafio_entrevista/providers/characters_provider.dart';
import 'package:desafio_entrevista/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarWarsApp extends StatelessWidget {
  const StarWarsApp({super.key, required this.charactersRepository});

  final CharactersRepository charactersRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: Color(0xfff5c542),
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),

        dividerTheme: DividerThemeData(color: Colors.grey.shade700),

        colorScheme: ColorScheme(
          onPrimary: Color(0xfff5c542),
          onSecondary: Color(0xFFC1121F),
          error: Colors.red,
          onError: Colors.red,
          brightness: Brightness.dark,
          surface: Color(0xFF1C1F26),
          primary: Color(0xfff5c542),
          secondary: Color(0xFFC1121F),
          onSurface: Color(0xfff5c542),
        ),
      ),
      home: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => CharactersProvider(charactersRepository),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
