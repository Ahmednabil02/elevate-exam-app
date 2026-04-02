import 'package:exam_app/config/base_response/entity/meta_entity.dart';

class BasePaginationEntity<T> {
final MetaEntity meta;
  final List<T> data;

  BasePaginationEntity({
    required this.meta,
    required this.data,
  });

}