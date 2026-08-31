import 'package:flutter/material.dart';
import 'package:green_bin_employee/utils/app_colors.dart';
import 'package:green_bin_employee/views/edit_profile_screen.dart';
import 'package:green_bin_employee/views/help_support_page.dart';
import 'package:green_bin_employee/views/history_screen.dart';
import 'package:green_bin_employee/views/pickup_details_screen.dart';
import 'package:green_bin_employee/views/profile_screen.dart';
import 'package:green_bin_employee/views/scrap_items.dart';

// Separate the home *content* from the screen that owns the nav bar.
class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  int selectedNavIndex = 0;

  // Home content lives in its own widget (see HomeTab below),
  // NOT the EmployeeHomeScreen itself.
  final List<Widget> _pages = const [
    HomeTab(),
    HistoryScreen(),
    HelpSupportPage(),
    ProfileScreen(),
    EditProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: selectedNavIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // keeps labels/colors consistent with 4 items
        currentIndex: selectedNavIndex,
        selectedItemColor: CardGreen,
        unselectedItemColor: Black,
        onTap: (index) {
          setState(() {
            selectedNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.headphones), label: "Help"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
// -------------------------------------------------
//---------------------------------------------------
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      children: [
        _buildGreeting(),
        const SizedBox(height: 16),
        _buildBanner(),
        const SizedBox(height: 20),
        _buildMenuCard(
          context: context,
          title: 'Scrap Pickup',
          icon: Icons.local_shipping,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PickupDetailsPage()));
          },
        ),
        const SizedBox(height: 8),
        _buildMenuCard(
          context: context,
          title: 'Scrap Items',
          icon: Icons.receipt_long_sharp,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScrapItemPage()));
          },
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            'Recent Orders',
            style: TextStyle(color: Black, fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 7),
        _OrderCard(
          orderId: 'SG-98454',
          customerName: 'Customer Name',
          location: 'Perinthalmanna',
          dateTime: 'July 24, 2026    9:45 AM',
          status: 'Paid',
        ),
        const SizedBox(height: 12),
        _OrderCard(
          orderId: 'SG-98454',
          customerName: 'Customer Name',
          location: 'Perinthalmanna',
          dateTime: 'May 20, 2026     9:45 AM',
          status: 'Paid',
        ),
        const SizedBox(height: 12),
        _OrderCard(
          orderId: 'SG-98454',
          customerName: 'Customer Name',
          location: 'Perinthalmanna',
          dateTime: 'July 10, 2026    9:45 AM',
          status: 'Paid',
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildGreeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
          children: [
            TextSpan(text: 'Good Morning, ', style: TextStyle(color: Black)),
            TextSpan(
              text: 'Employee!',
              style: TextStyle(color: CardGreen, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        'assets/home_image.png',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            width: double.infinity,
            color: CardGreen.withOpacity(0.1),
            child: const Icon(Icons.image_outlined, size: 50, color: CardGreen),
          );
        },
      ),
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: White,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Green, width: 1),
        boxShadow: [
          BoxShadow(
            color: CardGreen.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: DarkGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: CardGreen, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.black, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String location;
  final String dateTime;
  final String status;

  const _OrderCard({
    required this.orderId,
    required this.customerName,
    required this.location,
    required this.dateTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Green, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order#$orderId', style: const TextStyle(color: Grey, fontSize: 13)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: CardGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(customerName,
              style: const TextStyle(color: Black, fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: CardGreen, size: 16),
              const SizedBox(width: 4),
              Text(location, style: const TextStyle(color: Grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.event_available_outlined, color: CardGreen, size: 16),
              const SizedBox(width: 4),
              Text(dateTime, style: const TextStyle(color: Grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}