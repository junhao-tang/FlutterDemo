import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  const Album(
    this.title,
    this.imageUrl,
    this.artist,
  );

  final String title;
  final String imageUrl;
  final Artist artist;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
