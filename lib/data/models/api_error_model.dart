import '../../../core/resources/base_model.dart';

class ApiErrorModel extends BaseModel {
  String? type;
  String? title;
  int? status;
  String? detail;
  String? instance;
  List<ApiErrorItemModel>? errors;

  ApiErrorModel({
    this.type,
    this.title,
    this.status,
    this.detail,
    this.instance,
    this.errors,
  });

  ApiErrorModel.fromJson(Map<String, dynamic> map) {
    type = map['type'];
    title = map['title'];
    status = map['status'];
    detail = map['detail'];
    instance = map['instance'];
    errors = map['errors'] != null
        ? (map['errors'] as List)
            .map((e) => ApiErrorItemModel.fromJson(e))
            .toList()
        : null;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['status'] = status;
    data['detail'] = detail;
    data['instance'] = instance;
    data['errors'] = errors;
    return data;
  }

  @override
  String toString() {
    return 'ApiErrorModel{'
        'type: $type, '
        'title: $title, '
        'status: $status, '
        'detail: $detail, '
        'instance: $instance,'
        'errors: $errors'
        '}';
  }
}

class ApiErrorItemModel {
  final String? code;
  final String? message;

  ApiErrorItemModel({this.code, this.message});

  factory ApiErrorItemModel.fromJson(Map<String, dynamic> map) {
    return ApiErrorItemModel(
      code: map['code'],
      message: map['message'],
    );
  }
}
