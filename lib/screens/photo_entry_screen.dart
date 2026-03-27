import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/medicine_provider.dart';
import '../models/medicine.dart';

class PhotoEntryScreen extends StatefulWidget {
  const PhotoEntryScreen({Key? key}) : super(key: key);

  @override
  State<PhotoEntryScreen> createState() => _PhotoEntryScreenState();
}

class _PhotoEntryScreenState extends State<PhotoEntryScreen> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  // 拍照阶段
  int _photoStage = 0; // 0:等待, 1:正面, 2:有效期, 3:其他, 4:完成
  final List<File> _photos = [];

  // 表单数据
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _categoryController = TextEditingController();
  final _totalQuantityController = TextEditingController();
  final _remainingQuantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _purchaseChannelController = TextEditingController();
  final _purchaseAddressController = TextEditingController();
  final _remarksController = TextEditingController();

  String _purchaseMethod = '线上';
  DateTime _expiryDate = DateTime.now().add(const Duration(days: 365));

  // OCR识别结果
  String _ocrName = '';
  String _ocrBrand = '';
  String _ocrExpiryDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拍照录入'),
        backgroundColor: const Color(0xFF00C896),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_photoStage) {
      case 0:
        return _buildPhotoGuide();
      case 1:
      case 2:
      case 3:
        return _buildPhotoTaking();
      case 4:
        return _buildFormEntry();
      default:
        return _buildPhotoGuide();
    }
  }

  Widget _buildPhotoGuide() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              size: 80,
              color: Colors.green[200],
            ),
            const SizedBox(height: 24),
            const Text(
              '药品拍照录入',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '请按步骤拍摄药品包装照片',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            _buildStepItem(
              step: 1,
              title: '拍摄正面',
              description: '拍摄药品包装正面，包含名称、品牌等信息',
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              step: 2,
              title: '拍摄有效期',
              description: '拍摄背面或侧面，包含生产日期和有效期',
            ),
            const SizedBox(height: 16),
            _buildStepItem(
              step: 3,
              title: '拍摄其他角度',
              description: '可拍摄其他角度作为补充',
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _photoStage = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C896),
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '开始拍照',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required int step,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF00C896),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoTaking() {
    String title;
    String instruction;

    switch (_photoStage) {
      case 1:
        title = '第1步：拍摄正面';
        instruction = '请拍摄药品包装正面，确保药品名称、品牌等信息清晰可见';
        break;
      case 2:
        title = '第2步：拍摄有效期';
        instruction = '请拍摄药品包装的背面或侧面，确保生产日期和有效期清晰可见';
        break;
      case 3:
        title = '第3步：拍摄其他角度';
        instruction = '可继续拍摄其他角度，或点击"跳过"直接进入下一步';
        break;
      default:
        title = '';
        instruction = '';
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green[50],
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                instruction,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _photos.isNotEmpty && _photoStage > 1
                    ? Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.file(
                          _photos[_photos.length - 1],
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.camera_alt,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _takePhoto('camera'),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('拍照'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C896),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => _takePhoto('gallery'),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('相册'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (_photoStage > 1)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _photoStage--;
                      });
                    },
                    child: const Text('上一步'),
                  ),
                ),
              if (_photoStage > 1) const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _photoStage < 3
                      ? () {
                          setState(() {
                            _photoStage++;
                          });
                        }
                      : () {
                          setState(() {
                            _photoStage = 4;
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C896),
                  ),
                  child: Text(_photoStage < 3 ? '下一步' : '完成'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormEntry() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OCR识别结果
            if (_ocrName.isNotEmpty || _ocrBrand.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '识别结果',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    if (_ocrName.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('药品名称: $_ocrName'),
                    ],
                    if (_ocrBrand.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('品牌: $_ocrBrand'),
                    ],
                  ],
                ),
              ),

            // 基本信息
            _buildSectionTitle('基本信息'),
            _buildTextField(
              controller: _nameController,
              label: '药品名称',
              hint: _ocrName.isEmpty ? '例如：感冒灵颗粒' : null,
              required: true,
            ),
            _buildTextField(
              controller: _brandController,
              label: '品牌',
              hint: _ocrBrand.isEmpty ? '例如：999' : null,
              required: true,
            ),
            _buildTextField(
              controller: _categoryController,
              label: '分类',
              hint: '例如：感冒药',
              required: true,
            ),

            const SizedBox(height: 16),

            // 数量信息
            _buildSectionTitle('数量信息'),
            _buildTextField(
              controller: _totalQuantityController,
              label: '总量',
              hint: '例如：30粒',
              required: true,
            ),
            _buildTextField(
              controller: _remainingQuantityController,
              label: '剩余量',
              hint: '例如：30粒',
              required: true,
            ),

            const SizedBox(height: 16),

            // 购买信息
            _buildSectionTitle('购买信息'),
            _buildDropdownField(
              label: '购买方式',
              value: _purchaseMethod,
              items: ['线上', '线下'],
              onChanged: (value) {
                setState(() {
                  _purchaseMethod = value!;
                });
              },
            ),
            _buildTextField(
              controller: _purchaseChannelController,
              label: '购买渠道',
              hint: '例如：京东、美团、某某药店',
            ),
            _buildTextField(
              controller: _purchaseAddressController,
              label: '购买地址',
              hint: '例如：北京朝阳区xxx药店',
            ),
            _buildTextField(
              controller: _priceController,
              label: '价格',
              hint: '例如：25.00',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            // 有效期
            _buildSectionTitle('有效期'),
            InkWell(
              onTap: _selectExpiryDate,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '有效期至: ${_formatDate(_expiryDate)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 备注
            _buildSectionTitle('备注'),
            _buildTextField(
              controller: _remarksController,
              label: '备注',
              hint: '可选填写',
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            // 提交按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C896),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '保存',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          suffixText: required ? ' *' : null,
          suffixStyle: const TextStyle(color: Colors.red),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '请输入$label';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _takePhoto(String source) async {
    final XFile? image;
    try {
      if (source == 'camera') {
        image = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
        );
      } else {
        image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );
      }

      if (image != null) {
        setState(() {
          _photos.add(File(image.path));
          // 模拟OCR识别（实际项目中需要集成OCR服务）
          _simulateOCR();
        });

        // 自动进入下一步
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_photoStage < 3) {
            setState(() {
              _photoStage++;
            });
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('拍照失败: $e')),
      );
    }
  }

  void _simulateOCR() {
    // 模拟OCR识别结果
    setState(() {
      if (_photoStage == 1) {
        _ocrName = '感冒灵颗粒';
        _ocrBrand = '999';
      } else if (_photoStage == 2) {
        _ocrExpiryDate = '2026-03-27';
      }
    });
  }

  Future<void> _selectExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final medicine = Medicine(
      name: _nameController.text,
      brand: _brandController.text,
      category: _categoryController.text,
      totalQuantity: _totalQuantityController.text,
      remainingQuantity: _remainingQuantityController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      purchaseMethod: _purchaseMethod,
      purchaseChannel: _purchaseChannelController.text,
      purchaseAddress: _purchaseAddressController.text,
      purchaseDate: DateTime.now(),
      expiryDate: _expiryDate,
      userId: 1, // 使用当前登录用户ID
      status: MedicineStatus.normal,
      remarks: _remarksController.text.isEmpty ? null : _remarksController.text,
    );

    final success = await context.read<MedicineProvider>().addMedicine(medicine);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('保存成功')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('保存失败')),
      );
    }
  }
}
