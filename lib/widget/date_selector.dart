import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class DateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const DateSelector({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final hasDate = selectedDate != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: White,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color:LightGrey, width: 1.2),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: CardGreen,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hasDate ? _formatDate(selectedDate!) : 'Select Date',
                style: TextStyle(
                  fontSize: 14,
                  color: hasDate ? Black : Grey,
                  fontWeight: hasDate ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Grey,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}