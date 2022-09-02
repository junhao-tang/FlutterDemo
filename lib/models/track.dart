import 'package:json_annotation/json_annotation.dart';

import 'album.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  Track(
    this.title,
    this.liked,
    this.album,
  );

  final String title;
  final bool liked;
  final Album album;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
