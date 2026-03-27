import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: const Color(0xFF00C896),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 过期提醒设置
              _buildSectionTitle('过期提醒'),
              _buildSwitchItem(
                title: '开启过期提醒',
                subtitle: '药品即将过期时发送通知',
                value: provider.expiryNotificationEnabled,
                onChanged: (value) {
                  provider.setExpiryNotificationEnabled(value);
                },
              ),
              _buildNumberPickerItem(
                title: '提前提醒天数',
                subtitle: '在过期前多少天开始提醒',
                value: provider.expiryNotificationDays,
                minValue: 1,
                maxValue: 90,
                onChanged: (value) {
                  provider.setExpiryNotificationDays(value);
                },
              ),
              _buildTimePickerItem(
                title: '提醒时间',
                subtitle: '每天发送提醒的时间',
                value: provider.expiryNotificationTime,
                onChanged: (value) {
                  provider.setExpiryNotificationTime(value);
                },
              ),

              const SizedBox(height: 24),

              // 关于
              _buildSectionTitle('关于'),
              _buildAboutItem(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF00C896),
      ),
    );
  }

  Widget _buildNumberPickerItem({
    required String title,
    required String subtitle,
    required int value,
    required int minValue,
    required int maxValue,
    required Function(int) onChanged,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: value > minValue
                  ? () => onChanged(value - 1)
                  : null,
            ),
            SizedBox(
              width: 40,
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: value < maxValue
                  ? () => onChanged(value + 1)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerItem({
    required String title,
    required String subtitle,
    required String value,
    required Function(String) onChanged,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: () async {
                final parts = value.split(':');
                final initialTime = TimeOfDay(
                  hour: int.parse(parts[0]),
                  minute: int.parse(parts[1]),
                );

                final picked = await showTimePicker(
                  context: context,
                  initialTime: initialTime,
                );

                if (picked != null) {
                  final hour = picked.hour.toString().padLeft(2, '0');
                  final minute = picked.minute.toString().padLeft(2, '0');
                  onChanged('$hour:$minute');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem() {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: const Text('应用版本'),
            trailing: const Text('1.0.0'),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('开发者'),
            trailing: const Text('个人自研'),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('联系方式'),
            trailing: const Text('-'),
          ),
        ],
      ),
    );
  }
}
