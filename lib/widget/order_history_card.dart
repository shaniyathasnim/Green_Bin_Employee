import 'package:flutter/material.dart';
import 'package:green_bin_employee/models/order_history_model.dart';
import 'package:green_bin_employee/utils/app_colors.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderHistory order;

  const OrderHistoryCard({super.key, required this.order});

  // Local color constants for pixel-perfect matching as per prompt
  static const Color primaryGreen = Color(0xFF007F4F);
  static const Color darkText = Color(0xFF292929);
  static const Color greyText = Color(0xFF777777);
  static const Color cardBackground = Color(0xFFF0F7F8);
  static const Color customBorderColor = Color(0xFFB7C8C5);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: customBorderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order#${order.orderId}',
                style: const TextStyle(
                  color: greyText,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            order.residentName,
            style: const TextStyle(
              color: darkText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: primaryGreen, size: 14),
              const SizedBox(width: 4),
              Text(
                order.location,
                style: const TextStyle(
                  color: greyText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.event, color: primaryGreen, size: 14),
              const SizedBox(width: 4),
              Text(
                '${order.date}   ${order.time}',
                style: const TextStyle(
                  color: darkText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
