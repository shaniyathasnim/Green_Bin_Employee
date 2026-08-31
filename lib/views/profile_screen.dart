import 'package:flutter/material.dart';
import 'package:green_bin_employee/utils/app_colors.dart';
import 'package:green_bin_employee/views/edit_profile_screen.dart';
import 'package:green_bin_employee/views/login_screen.dart';
import 'package:green_bin_employee/widget/profile_detail_tile.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // 4. Top Profile Title
              const Center(
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Black,
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // 5. & 6. Profile Image with Edit Button
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: LightGrey,
                      backgroundImage: AssetImage('assets/profile_img.jpg'),
                      // Fallback if image not found
                      // child: Icon(Icons.person, size: 50, color: Grey),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Implement edit profile logic
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color:White,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 15,
                            color: CardGreen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // 7. User Name
              const Text(
                'Arun',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Black,
                ),
              ),
              const SizedBox(height: 4),

              // 8. Joined Date
              const Text(
                'Joined : Sep 2022',
                style: TextStyle(
                  fontSize: 14,
                  color: Grey,
                ),
              ),
              const SizedBox(height: 35),

              // 9. Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: LightGreen,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: CardGreen.withOpacity(0.09),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // 10. Details Title
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 11. Detail Rows
                      ProfileDetailTile(
                        label: 'Name',
                        value: 'Arun',
                        icon: Icons.person_outline,
                      ),
                      ProfileDetailTile(
                        label: 'Contact Number',
                        value: '+91 7334060633',
                        icon: Icons.phone_outlined,
                      ),
                      ProfileDetailTile(
                        label: 'Address',
                        value: '20th Mile, Perinthalmanna',
                        icon: Icons.location_on_outlined,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // 20. Logout Button
              Center(
                child: GestureDetector(
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(
                       builder: (context) => const EmployeeLoginScreen()));
                  },
                  child: Container(
                    width: 156,
                    height: 44,
                    decoration: BoxDecoration(
                      color: LightRed,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: LogoutRed,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.logout,
                          color: LogoutRed,
                          size: 18,
                        ),
                      ],
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
