import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_nav_bar.dart';
import '../screens/review_screen.dart';

class AboutCompanyScreen extends StatelessWidget {
  final String company;
  final String logoPath;
  final Color color;

  const AboutCompanyScreen({
    super.key,
    required this.company,
    required this.logoPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'About Company',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Company Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset(
                      logoPath,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    company,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Response Time Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewScreen(
                      company: company,
                      logoPath: logoPath,
                      color: color,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Usually Replies',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'in 1 day.',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Container(
                      width: 3,
                      height: 40,
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: index < 4 ? const Color(0xFFCCFF00) : Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.description_outlined,
                                    color: index < 4 ? Colors.black : Colors.grey,
                                    size: 16,
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '1000+ Reviewers',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Company Details
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDetailItem(
                    company,
                    _getCompanyDescription(),
                    Icons.check_circle_outline,
                  ),
                  _buildDetailItem(
                    'Industry',
                    'Music Broadcasting',
                    Icons.business_outlined,
                  ),
                  _buildDetailItem(
                    'Website',
                    'www.spotify.com',
                    Icons.language_outlined,
                  ),
                  _buildDetailItem(
                    'Company Size',
                    '1500 - 2000 Employee',
                    Icons.people_outline,
                  ),
                  _buildDetailItem(
                    'Headquaters',
                    'Stockholm, Sweden',
                    Icons.location_on_outlined,
                  ),
                  _buildDetailItem(
                    'Founded',
                    '2006',
                    Icons.calendar_today_outlined,
                  ),
                ],
              ),
            ),

            // Bottom Navigation
            const BottomNavBar(currentIndex: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 252, 252, 252),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFFCCFF00),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCompanyDescription() {
    switch (company.toLowerCase()) {
      case 'spotify':
        return "In a UX Designer job, you'll need both types of skills to develop the next generation of products. You'll partner with Researchers and Designers to define and deliver new features.";
      case 'google':
        return "As a Software Engineer at Google, you'll work on complex systems and innovative solutions that help organize the world's information.";
      case 'airbnb':
        return "Join Airbnb to help create a world where anyone can belong anywhere. You'll work on projects that make travel more accessible and meaningful.";
      case 'microsoft':
        return "At Microsoft, you'll be empowered to work on projects that help every person and organization on the planet achieve more.";
      case 'apple':
        return "At Apple, you'll do more than join something — you'll help shape the future of technology and innovation.";
      default:
        return "Join our team to work on exciting projects and make a meaningful impact in the industry.";
    }
  }
} 