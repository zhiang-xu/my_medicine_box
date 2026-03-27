class MedicineImage {
  final int? id;
  final int medicineId;       // 关联的药品ID
  final String imagePath;     // 图片路径
  final ImageType type;       // 图片类型
  final DateTime createdAt;  // 创建时间

  MedicineImage({
    this.id,
    required this.medicineId,
    required this.imagePath,
    required this.type,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // 复制并修改
  MedicineImage copyWith({
    int? id,
    int? medicineId,
    String? imagePath,
    ImageType? type,
    DateTime? createdAt,
  }) {
    return MedicineImage(
      id: id ?? this.id,
      medicineId: medicineId ?? this.medicineId,
      imagePath: imagePath ?? this.imagePath,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicineId': medicineId,
      'imagePath': imagePath,
      'type': type.index,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // 从Map创建
  factory MedicineImage.fromMap(Map<String, dynamic> map) {
    return MedicineImage(
      id: map['id'] as int?,
      medicineId: map['medicineId'] as int,
      imagePath: map['imagePath'] as String,
      type: ImageType.values[map['type'] as int],
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }
}

// 图片类型枚举
enum ImageType {
  front,     // 正面图（药品名称、品牌）
  expiry,    // 有效期图
  other,     // 其他角度
}
