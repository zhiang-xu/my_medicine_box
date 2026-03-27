import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/medicine.dart';
import '../providers/medicine_provider.dart';

class MedicineDetailScreen extends StatefulWidget {
  final Medicine medicine;

  const MedicineDetailScreen({Key? key, required this.medicine})
      : super(key: key);

  @override
  State<MedicineDetailScreen> createState() => _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends State<MedicineDetailScreen> {
  late TextEditingController _remainingController;

  @override
  void initState() {
    super.initState();
    _remainingController = TextEditingController(
      text: widget.medicine.remainingQuantity,
    );
  }

  @override
  void dispose() {
    _remainingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicine = widget.medicine;

    return Scaffold(
      appBar: AppBar(
        title: const Text('药品详情'),
        backgroundColor: const Color(0xFF00C896),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _showDeleteDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 状态卡片
            _buildStatusCard(medicine),

            const SizedBox(height: 24),

            // 基本信息
            _buildSectionTitle('基本信息'),
            _buildInfoRow('药品名称', medicine.name),
            _buildInfoRow('品牌', medicine.brand),
            _buildInfoRow('分类', medicine.category),

            const SizedBox(height: 24),

            // 数量信息
            _buildSectionTitle('数量信息'),
            _buildInfoRow('总量', medicine.totalQuantity),
            _buildQuantityRow('剩余量', medicine.remainingQuantity),

            const SizedBox(height: 24),

            // 有效期
            _buildSectionTitle('有效期'),
            _buildExpiryInfo(medicine),

            const SizedBox(height: 24),

            // 购买信息
            _buildSectionTitle('购买信息'),
            _buildInfoRow('购买方式', medicine.purchaseMethod),
            _buildInfoRow('购买渠道', medicine.purchaseChannel),
            _buildInfoRow('购买地址', medicine.purchaseAddress),
            _buildInfoRow('购买日期', DateFormat('yyyy-MM-dd').format(medicine.purchaseDate)),
            _buildInfoRow('价格', '¥${medicine.price.toStringAsFixed(2)}'),

            const SizedBox(height: 24),

            // 状态管理
            _buildSectionTitle('状态管理'),
            _buildStatusActions(medicine),

            if (medicine.remarks != null && medicine.remarks!.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildSectionTitle('备注'),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(medicine.remarks!),
              ),
            ],

            const SizedBox(height: 24),

            // 录入信息
            _buildSectionTitle('录入信息'),
            _buildInfoRow('录入时间', DateFormat('yyyy-MM-dd HH:mm').format(medicine.createdAt)),

            const SizedBox(height: 32),

            // 搜索网上信息按钮
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _searchOnline,
                icon: const Icon(Icons.search),
                label: const Text('搜索网上药品信息'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(Medicine medicine) {
    Color bgColor;
    String statusText;

    if (medicine.isExpired) {
      bgColor = Colors.red;
      statusText = '已过期';
    } else if (medicine.isExpiringSoon) {
      bgColor = Colors.orange;
      final days = medicine.expiryDate.difference(DateTime.now()).inDays;
      statusText = '$days天后过期';
    } else {
      bgColor = Colors.green;
      statusText = '正常';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            medicine.isExpired ? Icons.warning : Icons.check_circle,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 12),
          Text(
            statusText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _remainingController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              // 更新剩余量
              // 这里应该调用provider更新
            },
            child: const Text('更新'),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryInfo(Medicine medicine) {
    final daysLeft = medicine.expiryDate.difference(DateTime.now()).inDays;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: medicine.isExpired
            ? Colors.red.withOpacity(0.1)
            : medicine.isExpiringSoon
                ? Colors.orange.withOpacity(0.1)
                : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: medicine.isExpired
              ? Colors.red
              : medicine.isExpiringSoon
                  ? Colors.orange
                  : Colors.green,
        ),
      ),
      child: Column(
        children: [
          Text(
            '有效期至: ${DateFormat('yyyy-MM-dd').format(medicine.expiryDate)}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            medicine.isExpired
                ? '已过期 ${daysLeft.abs()} 天'
                : '还剩 $daysLeft 天',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusActions(Medicine medicine) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildStatusButton(
          '用完',
          Icons.done_all,
          Colors.blue,
          () => _updateStatus(MedicineStatus.usedUp),
        ),
        _buildStatusButton(
          '损坏',
          Icons.broken_image,
          Colors.orange,
          () => _updateStatus(MedicineStatus.damaged),
        ),
        _buildStatusButton(
          '丢弃',
          Icons.delete_outline,
          Colors.red,
          () => _updateStatus(MedicineStatus.discarded),
        ),
        if (medicine.isExpired)
          _buildStatusButton(
            '标记过期',
            Icons.event_busy,
            Colors.red,
            () => _updateStatus(MedicineStatus.expired),
          ),
      ],
    );
  }

  Widget _buildStatusButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
      ),
    );
  }

  void _showEditDialog() {
    // 显示编辑对话框
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑药品信息'),
        content: const Text('编辑功能开发中...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这条药品记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await context
                  .read<MedicineProvider>()
                  .deleteMedicine(widget.medicine.id!);
              if (success && mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('删除成功')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  void _updateStatus(MedicineStatus status) {
    final updatedMedicine = widget.medicine.copyWith(
      status: status,
    );
    context.read<MedicineProvider>().updateMedicine(updatedMedicine).then((success) {
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已更新为${status.displayName}')),
        );
        Navigator.pop(context);
      }
    });
  }

  void _searchOnline() {
    // 跳转到网上搜索
    // 这里可以使用url_launcher打开浏览器
  }
}
