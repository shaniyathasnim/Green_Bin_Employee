import 'dart:io';
import 'package:flutter/material.dart';
import 'package:green_bin_employee/utils/app_colors.dart';
import 'package:green_bin_employee/widget/success_screen.dart';
import 'package:image_picker/image_picker.dart';


class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  // State variables
  String _selectedCategory = 'Overflowing Bin';
  final TextEditingController _problemController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();


  final List<String> _categories = [
    'Overflowing Bin',
    'Damaged Bin',
    'Missed Pickup',
    'Illegal Dumping',
  ];

  @override
  void dispose() {
    _problemController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error picking image')),
      );
    }
  }

  Future<void> _submit() async {
    if (_problemController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe your problem')),
      );
      return;
    }

    // TODO: Add your actual submission logic here (API call, etc.)

    // Clear state after submission
    final wasImageAttached = _selectedImage != null;
    setState(() {
      _problemController.clear();
      _selectedImage = null;
    });

    if (!mounted) return;

    // Navigate to the success screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HelpSuccessScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              const Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Black,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              const Text(
                'Contact your supervisor or support team for help.',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Grey,
                ),
              ),
              const SizedBox(height: 20),
              // Visiting List Label
              const Text(
                'Visiting List',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                  color: Black,
                ),
              ),
              const SizedBox(height: 12),
              // Category Chips
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? CardGreen : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? CardGreen : Green,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white :Black,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              // Describe Label
              const Text(
                'Describe your Problem',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Black,
                ),
              ),
              const SizedBox(height: 8),
              // Problem Text Area
              Container(
                height: 137,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Green),
                ),
                child: TextField(
                  controller: _problemController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Please provide details of your issue...',
                    hintStyle: TextStyle(
                      color: Grey,
                      fontSize: 12,
                    ),
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Attach Photo Section
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Green),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.attach_file, color: Colors.black, size: 21),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedImage == null
                            ? 'Attach Photo (Optional)'
                            : 'Photo Attached',
                        style: const TextStyle(
                          color: Black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: CardGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Upload',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CardGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}