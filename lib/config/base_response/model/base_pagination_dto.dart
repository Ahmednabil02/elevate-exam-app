import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/model/meta_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_pagination_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasePaginationDto<T> {
  final String? message;
  final MetaDto? metadata;
  final List<T>? data;

  const BasePaginationDto({this.message, this.metadata, this.data});

  factory BasePaginationDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$BasePaginationDtoFromJson(json, fromJsonT);

  factory BasePaginationDto.fromJsonWithKey(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT, {
    String dataKey = 'data',
  }) {
    return BasePaginationDto<T>(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetaDto.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json[dataKey] as List<dynamic>?)?.map(fromJsonT).toList(),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      _$BasePaginationDtoToJson(this, toJsonT);

  BasePaginationEntity<E> toEntity<E>(E Function(T) mapper) {
    return BasePaginationEntity(
      meta: metadata?.toEntity() ?? (throw Exception('metadata is null')),
      data: data?.map(mapper).toList() ?? [],
    );
  }
}
