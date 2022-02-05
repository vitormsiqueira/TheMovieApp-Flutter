import 'dart:convert';

class PersonDetail {
  PersonDetail({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  final bool? adult;
  final List<String>? alsoKnownAs;
  final String? biography;
  final DateTime? birthday;
  final dynamic deathday;
  final int? gender;
  final dynamic homepage;
  final int? id;
  final String? imdbId;
  final String? knownForDepartment;
  final String? name;
  final String? placeOfBirth;
  final double? popularity;
  final String? profilePath;

  factory PersonDetail.fromJson(String str) =>
      PersonDetail.fromMap(json.decode(str));

  factory PersonDetail.fromMap(Map<String, dynamic> json) => PersonDetail(
        adult: json["adult"] == null ? null : json["adult"],
        alsoKnownAs: json["also_known_as"] == null
            ? null
            : List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"] == null ? null : json["biography"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        deathday: json["deathday"],
        gender: json["gender"] == null ? null : json["gender"],
        homepage: json["homepage"],
        id: json["id"] == null ? null : json["id"],
        imdbId: json["imdb_id"] == null ? null : json["imdb_id"],
        knownForDepartment: json["known_for_department"] == null
            ? null
            : json["known_for_department"],
        name: json["name"] == null ? null : json["name"],
        placeOfBirth:
            json["place_of_birth"] == null ? null : json["place_of_birth"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );
}
