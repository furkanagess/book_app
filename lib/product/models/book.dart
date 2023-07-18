import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'book.g.dart';

@JsonSerializable()
@immutable
class Book with EquatableMixin {
  final String title;
  final String author;
  final String thumbnailUrl;
  final String description;

  Book({
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    required this.description,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  List<Object?> get props => [title, author, thumbnailUrl, description];

  Book copyWith({
    String? title,
    String? author,
    String? thumbnailUrl,
    String? description,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      description: description ?? this.description,
    );
  }
}
