import 'package:flutter/material.dart';
import 'package:green_bin_employee/utils/app_colors.dart';

class ProfileDetailTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const ProfileDetailTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 68,
      decoration: BoxDecoration(
        color: White,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Green,
          width: 0.8,
        ),
      ),
      child: Stack(
        children: [
          // Green left accent
          Positioned(
            left: 0,
            top:6,
            bottom:6 ,
            child: Container(
              width: 4,
              decoration: const BoxDecoration(
                color: CardGreen,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                // Icon Box
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: LightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: CardGreen,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                // Text details
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: Grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: Black,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
