class Medicine {
  final int? id;
  final String name;           // 药品名称
  final String brand;          // 品牌
  final String category;       // 分类
  final String totalQuantity;  // 总量（如：30粒、100ml）
  final String remainingQuantity; // 剩余量
  final double price;          // 价格
  final String purchaseMethod; // 购买方式（线上/线下）
  final String purchaseChannel; // 购买渠道（京东/美团/药店名称）
  final String purchaseAddress; // 购买地址
  final DateTime purchaseDate; // 购买日期
  final DateTime expiryDate;   // 有效期
  final int userId;            // 录入用户ID
  final MedicineStatus status; // 状态
  final String? remarks;       // 备注
  final DateTime createdAt;     // 创建时间
  final DateTime updatedAt;    // 更新时间

  Medicine({
    this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.totalQuantity,
    required this.remainingQuantity,
    required this.price,
    required this.purchaseMethod,
    required this.purchaseChannel,
    required this.purchaseAddress,
    required this.purchaseDate,
    required this.expiryDate,
    required this.userId,
    required this.status,
    this.remarks,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // 判断是否过期
  bool get isExpired => DateTime.now().isAfter(expiryDate);

  // 判断是否即将过期（30天内）
  bool get isExpiringSoon {
    final daysLeft = expiryDate.difference(DateTime.now()).inDays;
    return daysLeft > 0 && daysLeft <= 30;
  }

  // 判断是否正常
  bool get isNormal => !isExpired && !isExpiringSoon;

  // 复制并修改
  Medicine copyWith({
    int? id,
    String? name,
    String? brand,
    String? category,
    String? totalQuantity,
    String? remainingQuantity,
    double? price,
    String? purchaseMethod,
    String? purchaseChannel,
    String? purchaseAddress,
    DateTime? purchaseDate,
    DateTime? expiryDate,
    int? userId,
    MedicineStatus? status,
    String? remarks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      price: price ?? this.price,
      purchaseMethod: purchaseMethod ?? this.purchaseMethod,
      purchaseChannel: purchaseChannel ?? this.purchaseChannel,
      purchaseAddress: purchaseAddress ?? this.purchaseAddress,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      expiryDate: expiryDate ?? this.expiryDate,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      remarks: remarks ?? this.remarks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'totalQuantity': totalQuantity,
      'remainingQuantity': remainingQuantity,
      'price': price,
      'purchaseMethod': purchaseMethod,
      'purchaseChannel': purchaseChannel,
      'purchaseAddress': purchaseAddress,
      'purchaseDate': purchaseDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'userId': userId,
      'status': status.index,
      'remarks': remarks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // 从Map创建
  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] as int?,
      name: map['name'] as String,
      brand: map['brand'] as String,
      category: map['category'] as String,
      totalQuantity: map['totalQuantity'] as String,
      remainingQuantity: map['remainingQuantity'] as String,
      price: (map['price'] as num).toDouble(),
      purchaseMethod: map['purchaseMethod'] as String,
      purchaseChannel: map['purchaseChannel'] as String,
      purchaseAddress: map['purchaseAddress'] as String,
      purchaseDate: DateTime.parse(map['purchaseDate'] as String),
      expiryDate: DateTime.parse(map['expiryDate'] as String),
      userId: map['userId'] as int,
      status: MedicineStatus.values[map['status'] as int],
      remarks: map['remarks'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}

// 药品状态枚举
enum MedicineStatus {
  normal,      // 正常
  usedUp,      // 用完
  damaged,     // 损坏
  discarded,   // 丢弃
  expired,     // 过期
}

// 获取状态显示文本
extension MedicineStatusExtension on MedicineStatus {
  String get displayName {
    switch (this) {
      case MedicineStatus.normal:
        return '正常';
      case MedicineStatus.usedUp:
        return '用完';
      case MedicineStatus.damaged:
        return '损坏';
      case MedicineStatus.discarded:
        return '丢弃';
      case MedicineStatus.expired:
        return '过期';
    }
  }
}
