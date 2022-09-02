// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      json['title'] as String,
      json['liked'] as bool,
      Album.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'title': instance.title,
      'liked': instance.liked,
      'album': instance.album,
    };
