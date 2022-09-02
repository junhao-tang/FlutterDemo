// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      $enumDecode(_$RecommendationTypeEnumMap, json['type']),
      (json['playlists'] as List<dynamic>)
          .map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['title'] as String,
      json['artist'] == null
          ? null
          : Artist.fromJson(json['artist'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'type': _$RecommendationTypeEnumMap[instance.type]!,
      'playlists': instance.playlists,
      'title': instance.title,
      'artist': instance.artist,
    };

const _$RecommendationTypeEnumMap = {
  RecommendationType.normal: 'normal',
  RecommendationType.primary: 'primary',
  RecommendationType.recentlyplayed: 'recentlyplayed',
  RecommendationType.moreLike: 'moreLike',
  RecommendationType.discover: 'discover',
  RecommendationType.spotlight: 'spotlight',
};
