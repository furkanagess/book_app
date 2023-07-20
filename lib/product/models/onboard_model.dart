import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'onboard_model.g.dart';

@JsonSerializable()
@immutable
class OnBoardModel with EquatableMixin {
  final String? title;
  final String? description;
  final String? imagePath;

  OnBoardModel({
    this.title,
    this.description,
    this.imagePath,
  });

  factory OnBoardModel.fromJson(Map<String, dynamic> json) => _$OnBoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$OnBoardModelToJson(this);

  @override
  List<Object?> get props => [title, description, imagePath];

  OnBoardModel copyWith({
    String? title,
    String? description,
    String? imagePath,
  }) {
    return OnBoardModel(
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
