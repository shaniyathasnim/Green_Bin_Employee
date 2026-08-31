import 'package:flutter/material.dart';

import 'package:green_bin_employee/models/visitor_model.dart' hide Visitor;
import 'package:green_bin_employee/utils/app_colors.dart';
import 'package:green_bin_employee/widget/date_selector.dart';
import 'package:green_bin_employee/widget/visitor_card.dart' hide VisitorCard;

import '../models/visitor_model.dart';
import '../widget/visitor_card.dart';

class PickupDetailsPage extends StatefulWidget {
  const PickupDetailsPage({super.key});

  @override
  State<PickupDetailsPage> createState() => _PickupDetailsPageState();
}

class _PickupDetailsPageState extends State<PickupDetailsPage> {
  DateTime? _selectedDate;

  final String _pickupLocation = 'Pattambi';

  final List<Visitor> _visitors = [
    Visitor(
      name: 'Arun',
      location: 'Perinthalmanna',
      image: 'assets/images/arun.jpg',
    ),
    Visitor(
      name: 'Karthik',
      location: 'Perinthalmanna',
      image: 'assets/images/karthik.jpg',
    ),
    Visitor(
      name: 'Manu',
      location: 'Kottakkal',
      image: 'assets/images/manu.jpg',
    ),
    Visitor(
      name: 'Kate',
      location: 'Koppam',
      image: 'assets/images/kate.jpg',
    ),
    Visitor(
      name: 'Clare',
      location: 'Perinthalmanna',
      image: 'assets/images/clare.jpg',
    ),
  ];

  String get _weekday {
    final date = _selectedDate ?? DateTime(2026, 8, 24);

    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return days[date.weekday - 1];
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: CardGreen,
              onPrimary: White,
              onSurface: Black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    setState(() {
      _selectedDate = picked;
    });
  }

  void _markCompleted(int index) {
    setState(() {
      _visitors[index].isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: White,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            14,
            20,
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------------------------------------------------
              // HEADER
              // --------------------------------------------------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 2,
                        right: 8,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Black,
                      ),
                    ),
                  ),

                  const SizedBox(width: 2),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pickup Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Black,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          'Stay updated with your neighborhood waste '
                              'collection times.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.35,
                            color: Grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // --------------------------------------------------
              // DATE SELECTOR
              // --------------------------------------------------
              DateSelector(
                selectedDate: _selectedDate,
                onTap: _pickDate,
              ),

              const SizedBox(height: 10),

              // --------------------------------------------------
              // PICKUP DAY CARD
              // --------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: CardGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      _weekday,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: White,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 15,
                          color: Colors.yellow,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          _pickupLocation,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: White,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // VISITING LIST TITLE
              // --------------------------------------------------
              const Text(
                'Visiting List',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Black,
                ),
              ),

              const SizedBox(height: 10),

              // --------------------------------------------------
              // VISITOR LIST
              // --------------------------------------------------
              ListView.separated(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount: _visitors.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final visitor = _visitors[index];

                  return VisitorCard(
                    visitor: visitor,
                    onComplete: () {
                      _markCompleted(index);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}