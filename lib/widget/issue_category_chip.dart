import 'package:flutter/material.dart';

class IssueCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedBorderColor;

  const IssueCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? selectedColor : unselectedBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF292929),
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
