// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      json['title'] as String,
      json['imageUrl'] as String,
      Artist.fromJson(json['artist'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'artist': instance.artist,
    };
