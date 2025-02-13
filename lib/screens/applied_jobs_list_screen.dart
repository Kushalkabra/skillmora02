import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../providers/jobs_provider.dart';
import '../models/job_model.dart';

class AppliedJobsListScreen extends StatelessWidget {
  const AppliedJobsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobsProvider = Provider.of<JobsProvider>(context);
    final appliedJobs = jobsProvider.appliedJobsModel; // Use the model getter

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
                    'Jobs You Applied',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Devops!',
                          hintStyle: GoogleFonts.plusJakartaSans(
                            color: Colors.white54,
                          ),
                        ),
                        onChanged: (value) {
                          // Implement search functionality if needed
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Results Text
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Results',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Applied Jobs List
            Expanded(
              child: appliedJobs.isEmpty
                  ? Center(
                      child: Text(
                        'No applied jobs yet',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: appliedJobs.length,
                      itemBuilder: (context, index) {
                        final job = appliedJobs[index];
                        return _buildJobCard(
                          job.role,
                          job.company,
                          job.postedDate,
                          job.tags.contains('Hybrid') ? 'Hybrid' : 'Full Time',
                          _getApplicationStatus(index),
                          _getCompanyLogo(job.company),
                          isRejected: _isApplicationRejected(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCompanyLogo(String company) {
    switch (company.toLowerCase()) {
      case 'google':
        return 'assets/icons/google-178-svgrepo-com.svg';
      case 'airbnb':
        return 'assets/icons/airbnb-179-svgrepo-com.svg';
      case 'spotify':
        return 'assets/icons/spotify-svgrepo-com.svg';
      case 'microsoft':
        return 'assets/icons/microsoft-svgrepo-com.svg';
      case 'apple':
        return 'assets/icons/apple-inc-svgrepo-com.svg';
      default:
        return 'assets/icons/google-178-svgrepo-com.svg'; // Default logo
    }
  }

  String? _getApplicationStatus(int index) {
    // Mock status logic - you can implement real status tracking
    if (index == 0) return 'Reviewing';
    if (index == 3) return 'Rejected';
    return null;
  }

  bool _isApplicationRejected(int index) {
    return index == 3;
  }

  Widget _buildJobCard(
    String role,
    String company,
    String timeAgo,
    String type,
    String? status,
    String logoPath, {
    bool isRejected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Company Logo
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF2C2C2E),
            ),
            child: logoPath.endsWith('.svg')
                ? SvgPicture.asset(
                    logoPath,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  )
                : Image.asset(logoPath),
          ),
          const SizedBox(width: 12),
          
          // Job Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  company,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      timeAgo,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.white54,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      type,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    if (status != null) ...[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white54,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isRejected
                              ? Colors.red.withOpacity(0.2)
                              : const Color(0xFFFFB800).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.plusJakartaSans(
                            color: isRejected
                                ? Colors.red
                                : const Color(0xFFFFB800),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 