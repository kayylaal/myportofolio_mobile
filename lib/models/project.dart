import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

/// Project payload matching Django's ProjectSerializer.
@JsonSerializable()
class Project {
  const Project({
    this.id,
    required this.title,
    required this.description,
    this.link,
    this.thumbnail,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final int? id;

  final String title;
  final String description;
  final String? link;
  final String? thumbnail;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
