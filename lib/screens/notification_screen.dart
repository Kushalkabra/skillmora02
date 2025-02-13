import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_nav_bar.dart';
import './jobs_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with black background
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const JobsScreen(),
                            ),
                          );
                        },
                      ),
                      Text(
                        'Notification',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.pause_circle_outline),
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Content section with neon background
            Expanded(
              child: Container(
                color: const Color(0xFFCCFF00),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: _buildDateSection('Today'),
                      ),
                      _buildNotificationItem(
                        'Your application is moved to reviewing',
                        '1day Ago',
                        'Spotify Application Update',
                        'assets/icons/spotify-svgrepo-com.svg',
                      ),
                      _buildNotificationItem(
                        'Your application is moved to reviewing',
                        '1day Ago',
                        'Spotify Application Update',
                        'assets/icons/spotify-svgrepo-com.svg',
                      ),
                      _buildNotificationItem(
                        'Your application is moved to reviewing',
                        '1day Ago',
                        'Spotify Application Update',
                        'assets/icons/spotify-svgrepo-com.svg',
                      ),
                      const SizedBox(height: 8),
                      _buildDateSection('Last Week'),
                      _buildNotificationItem(
                        'Your application is moved to reviewing',
                        '1day Ago',
                        'Spotify Application Update',
                        'assets/icons/spotify-svgrepo-com.svg',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation
            const BottomNavBar(currentIndex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSection(String date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Text(
        date,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String time,
    String subtitle,
    String iconPath,
  ) {
    return Row(
      children: [
        // Bullet point
        Container(
          margin: const EdgeInsets.only(left: 16),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0),
            shape: BoxShape.circle,
          ),
        ),
        // Notification card
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 16, 12), // Adjusted left margin
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFFCCFF00),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            time,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 