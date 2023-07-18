// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      title: json['title'] as String,
      author: json['author'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
    };
