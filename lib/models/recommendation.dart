import 'package:flutter_demo/models/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation.g.dart';

enum RecommendationType {
  normal,
  primary,
  recentlyplayed,
  moreLike,
  discover,
  spotlight,
}

@JsonSerializable()
class Recommendation implements Comparable<Recommendation> {
  final RecommendationType type;
  final List<Playlist> playlists;
  final String title;
  final Artist? artist;

  Recommendation(this.type, this.playlists, this.title, this.artist);

  @override
  int compareTo(Recommendation other) {
    if (type == RecommendationType.primary) return -1;
    if (other.type == RecommendationType.primary) return 1;
    if (type == RecommendationType.spotlight) return -1;
    if (other.type == RecommendationType.spotlight) return 1;
    return 0;
  }

  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendationToJson(this);
}
