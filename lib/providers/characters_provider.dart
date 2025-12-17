import 'package:desafio_entrevista/data/models/character_model.dart';
import 'package:desafio_entrevista/data/repositories/characters_repository.dart';
import 'package:flutter/material.dart';

class CharactersProvider extends ChangeNotifier {
  final CharactersRepository repository;

  CharactersProvider(this.repository) {
    scrollController.addListener(_onScroll);
  }

  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  final List<CharacterModel> _characters = [];
  final List<CharacterModel> _favoriteCharacters = [];
  final List<CharacterModel> _searchedCharacters = [];
  bool _isLoading = false;

  bool _hasMore = true;
  int _page = 1;
  int _searchPage = 1;

  bool _isSearching = false;
  String? _error;
  String _query = '';

  List<CharacterModel> get characters {
    if (_query.isEmpty) {
      return _characters;
    }
    return _searchedCharacters;
  }

  List<CharacterModel> get favoriteCharacters => _favoriteCharacters;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;
  bool get isSearching => _isSearching;
  String get query => _query;

  bool get isEmpty {
    if (_isSearching) {
      return _searchedCharacters.isEmpty;
    }
    return _characters.isEmpty;
  }

  bool isFavorite(CharacterModel character) {
    return _favoriteCharacters.contains(character);
  }

  void toggleFavorite(CharacterModel character) {
    if (_favoriteCharacters.contains(character)) {
      _favoriteCharacters.remove(character);
    } else {
      _favoriteCharacters.add(character);
    }
    notifyListeners();
  }

  void startSearch() {
    _isSearching = true;
    _searchPage = 1;
    notifyListeners();
  }

  void stopSearch() {
    _isSearching = false;
    searchController.clear();
    _searchedCharacters.clear();
    _query = '';
    notifyListeners();
  }

  Future<void> onQueryChanged(String value) async {
    final q = value.trim();

    if (q.isEmpty) {
      _query = '';
      _searchedCharacters.clear();
      _searchPage = 1;
      notifyListeners();
      return;
    }

    _query = q;
    _searchPage = 1;
    await _search();
    notifyListeners();
  }

  Future<void> loadInitial() async {
    if (_characters.isNotEmpty) return;
    _characters.clear();
    _hasMore = true;
    await _load();
  }

  Future<void> loadNext() async {
    if (_isLoading || !_hasMore) return;
    if (_isSearching) {
      _searchPage++;
      return await _search();
    }
    _page++;
    return await _load();
  }

  Future<void> _search() async {
    if (_searchPage == 1) {
      _searchedCharacters.clear();
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await repository.search(_query, _searchPage);
      _searchedCharacters.addAll(response.results);
      _hasMore = response.next != null;
    } catch (e) {
      _error = e.toString();
      debugPrint(_error);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await repository.fetch(_page);

      _characters.addAll(response.results);
      _hasMore = response.next != null;
    } catch (e) {
      _error = e.toString();
      debugPrint(_error);
    }

    _isLoading = false;
    notifyListeners();
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (_isLoading || !_hasMore) return;

    final threshold = 200.0;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (maxScroll - currentScroll <= threshold) {
      loadNext();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
