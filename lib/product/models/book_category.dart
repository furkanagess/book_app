import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'book_category.g.dart';

@JsonSerializable()
@immutable
class BookCategory with EquatableMixin {
  final String name;

  BookCategory({
    required this.name,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) => _$BookCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$BookCategoryToJson(this);

  @override
  List<Object?> get props => [name];

  BookCategory copyWith({
    String? name,
  }) {
    return BookCategory(
      name: name ?? this.name,
    );
  }
}
