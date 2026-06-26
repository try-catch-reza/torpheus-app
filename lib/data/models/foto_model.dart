import 'package:equatable/equatable.dart';

class FotoModel extends Equatable {
  final String? id;
  final String? fileName;
  final String? contentType;
  final int? sizeInBytes;
  final String? url;
  final DateTime? createdAt;

  const FotoModel({
    this.id,
    this.fileName,
    this.contentType,
    this.sizeInBytes,
    this.url,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fileName': fileName,
      'contentType': contentType,
      'sizeInBytes': sizeInBytes,
      'url': url,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory FotoModel.fromMap(Map<String, dynamic> map) {
    return FotoModel(
      id: map['id'],
      fileName: map['fileName'],
      contentType: map['contentType'],
      sizeInBytes: map['sizeInBytes'],
      url: map['url'],
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fileName,
        contentType,
        sizeInBytes,
        url,
        createdAt,
      ];
}
