import 'dart:convert';

import 'package:desafio_entrevista/data/models/character_model.dart';

class PageResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<CharacterModel> results;

  PageResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PageResponseModel.fromRawJson(String str) =>
      PageResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PageResponseModel.fromJson(Map<String, dynamic> json) =>
      PageResponseModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<CharacterModel>.from(
          json["results"].map((x) => CharacterModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}
