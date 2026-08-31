import 'package:flutter/material.dart';
import 'package:green_bin_employee/models/order_history_model.dart';
import 'package:green_bin_employee/utils/app_colors.dart';
import 'package:green_bin_employee/widget/order_history_card.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Pixel-perfect color constants from prompt
  final List<OrderHistory> _allOrders = const [
    OrderHistory(
      orderId: 'SG-98454',
      residentName: 'Clare',
      location: 'Perinthalmanna',
      date: 'June 24, 2026',
      time: '9:45 AM',
      status: 'Paid',
    ),
    OrderHistory(
      orderId: 'SI-39901',
      residentName: 'Kate',
      location: 'Pattambi',
      date: 'July 5, 2026',
      time: '9:01 AM',
      status: 'Paid',
    ),
    OrderHistory(
      orderId: 'SZ-93334',
      residentName: 'Karthik',
      location: 'Nilambur',
      date: 'June 14, 2026',
      time: '10:25 AM',
      status: 'Paid',
    ),
    OrderHistory(
      orderId: 'SM-98001',
      residentName: 'Manu',
      location: 'Koppam',
      date: 'June 20, 2026',
      time: '1:00 AM',
      status: 'Paid',
    ),
    OrderHistory(
      orderId: 'SO-91554',
      residentName: 'Kate',
      location: 'Perinthalmanna',
      date: 'June 29, 2026',
      time: '2:05 AM',
      status: 'Paid',
    ),
  ];

  List<OrderHistory> _filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _filteredOrders = _allOrders;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOrders = _allOrders.where((order) {
        return order.orderId.toLowerCase().contains(query) ||
            order.residentName.toLowerCase().contains(query) ||
            order.location.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: White,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pickup History",style: TextStyle(color: Black,fontSize: 15,fontWeight: FontWeight.w700),),
              const SizedBox(height: 10),
              // Header
              const Text(
                'View all Orders, Active, and Completed scrap collection records.',
                style: TextStyle(
                  color: Grey,
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              // Search Field
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color:White,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color:Green),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search by house or resident,...',
                    hintStyle: TextStyle(color: Color(0xFFBDBDBD), fontSize: 13),
                    prefixIcon: Icon(Icons.search, color: CardGreen, size: 22),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // List of Orders
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredOrders.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    return OrderHistoryCard(order: _filteredOrders[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
