import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/bottom_nav_bar.dart';

class ReviewScreen extends StatefulWidget {
  final String company;
  final String logoPath;
  final Color color;

  const ReviewScreen({
    super.key,
    required this.company,
    required this.logoPath,
    required this.color,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int selectedRating = 0;

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
                    'Review',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Company Logo and Name
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: 8,
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset(
                      widget.logoPath,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.company,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Update the Review Card section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'How was your\noverall experience\nwith ${widget.company}?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Rating Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Overall Rating',
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFFCCFF00),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.description_outlined,
                            color: index < selectedRating ? const Color(0xFFCCFF00) : Colors.white,
                            size: 28,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Additional Review
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write your review here...',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Save Button
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCCFF00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Save',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const BottomNavBar(currentIndex: 0),
          ],
        ),
      ),
    );
  }
} 