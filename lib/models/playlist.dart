import 'package:flutter_wheel/models/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class Playlist {
  Playlist(
    this.id,
    this.title,
    this.description,
    this.likes, {
    this.imageUrl,
    this.tracks,
  });

  final int id;
  final String title;
  final String? imageUrl;
  final String description;
  final int likes;
  List<Track>? tracks;

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}
