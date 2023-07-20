// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnBoardModel _$OnBoardModelFromJson(Map<String, dynamic> json) => OnBoardModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$OnBoardModelToJson(OnBoardModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imagePath': instance.imagePath,
    };
