import 'package:flutter/material.dart';
import '../models/visitor_model.dart';
import '../utils/app_colors.dart';

class VisitorCard extends StatelessWidget {
  final Visitor visitor;
  final VoidCallback onComplete;

  const VisitorCard({
    super.key,
    required this.visitor,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: White,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Green, width: 1.1),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              visitor.image,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: 44,
                  height: 44,
                  color: White,
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                width: 44,
                height: 44,
                color: White,
                alignment: Alignment.center,
                child: Text(
                  visitor.name.isNotEmpty
                      ? visitor.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: CardGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  visitor.name,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: Black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: CardGreen,
                    ),
                    const SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        visitor.location,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: Grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: visitor.isCompleted ? null : onComplete,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: visitor.isCompleted
                    ? Grey.withOpacity(0.1)
                    : CardGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                visitor.isCompleted ? 'COMPLETED' : 'COMPLETE',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}