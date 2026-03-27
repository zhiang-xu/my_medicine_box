import 'package:flutter/material.dart';
import '../models/medicine.dart';
import 'package:intl/intl.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback? onTap;

  const MedicineCard({
    Key? key,
    required this.medicine,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 判断过期状态颜色
    Color getStatusColor() {
      if (medicine.isExpired) return Colors.red;
      if (medicine.isExpiringSoon) return Colors.orange;
      return Colors.green;
    }

    String getStatusText() {
      if (medicine.isExpired) return '已过期';
      if (medicine.isExpiringSoon) {
        final days = medicine.expiryDate.difference(DateTime.now()).inDays;
        return '$days天后过期';
      }
      return '正常';
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicine.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${medicine.brand} · ${medicine.category}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      getStatusText(),
                      style: TextStyle(
                        fontSize: 12,
                        color: getStatusColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                children: [
                  _buildInfoItem(
                    '剩余',
                    medicine.remainingQuantity,
                    Icons.inventory_2_outlined,
                  ),
                  const SizedBox(width: 16),
                  _buildInfoItem(
                    '总量',
                    medicine.totalQuantity,
                    Icons.inventory,
                  ),
                  const SizedBox(width: 16),
                  _buildInfoItem(
                    '有效期至',
                    DateFormat('yyyy-MM-dd').format(medicine.expiryDate),
                    Icons.event,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
