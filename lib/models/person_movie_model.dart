import 'dart:convert';

class PersonMovieModel {
  PersonMovieModel({
    this.title,
    this.id,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.voteCount,
    this.video,
    this.voteAverage,
    this.adult,
    this.overview,
    this.releaseDate,
    this.popularity,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  final String? title;
  final int? id;
  final String? backdropPath;
  final List<int>? genreIds;
  final OriginalLanguage? originalLanguage;
  final String? originalTitle;
  final String? posterPath;
  final int? voteCount;
  final bool? video;
  final double? voteAverage;
  final bool? adult;
  final String? overview;
  final String? releaseDate;
  final double? popularity;
  final String? character;
  final String? creditId;
  final int? order;
  final Department? department;
  final String? job;

  factory PersonMovieModel.fromJson(String str) =>
      PersonMovieModel.fromMap(json.decode(str));

  factory PersonMovieModel.fromMap(Map<String, dynamic> json) =>
      PersonMovieModel(
        title: json["title"] == null ? null : json["title"],
        id: json["id"] == null ? null : json["id"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        genreIds: json["genre_ids"] == null
            ? null
            : List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"] == null
            ? null
            : originalLanguageValues.map[json["original_language"]],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        video: json["video"] == null ? null : json["video"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        adult: json["adult"] == null ? null : json["adult"],
        overview: json["overview"] == null ? null : json["overview"],
        releaseDate: json["release_date"] == null ? null : json["release_date"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        character: json["character"] == null ? null : json["character"],
        creditId: json["credit_id"] == null ? null : json["credit_id"],
        order: json["order"] == null ? null : json["order"],
        department: json["department"] == null
            ? null
            : departmentValues.map[json["department"]],
        job: json["job"] == null ? null : json["job"],
      );
}

enum Department { DIRECTING, PRODUCTION, WRITING }

final departmentValues = EnumValues({
  "Directing": Department.DIRECTING,
  "Production": Department.PRODUCTION,
  "Writing": Department.WRITING
});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);
}
