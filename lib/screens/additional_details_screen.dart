import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_data.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  const AdditionalDetailsScreen({super.key});

  @override
  State<AdditionalDetailsScreen> createState() => _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
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
                    'Additional Details',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      'Education',
                      Icons.school_outlined,
                      onAdd: () => _showEducationDialog(),
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Languages Known',
                      Icons.language_outlined,
                      onAdd: () => _showLanguageDialog(),
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      'Courses & Certificates',
                      Icons.card_membership_outlined,
                      onAdd: () => _showCertificateDialog(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, {required VoidCallback onAdd}) {
    return GestureDetector(
      onTap: () => _showSectionDetails(title),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: const Color(0xFFCCFF00), size: 20),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFFCCFF00),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, 
                        color: Color(0xFFCCFF00)
                      ),
                      onPressed: onAdd,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSectionDetails(String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  children: _getContentForSection(title),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getContentForSection(String title) {
    switch (title) {
      case 'Education':
        return UserData.education.map((edu) => _buildDetailCard(edu)).toList();
      case 'Languages Known':
        return UserData.languages.map((lang) => _buildLanguageCard(lang)).toList();
      case 'Courses & Certificates':
        return UserData.certificates.map((cert) => _buildCertificateCard(cert)).toList();
      default:
        return [];
    }
  }

  Widget _buildDetailCard(Map<String, dynamic> edu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  edu['education'] ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    '${edu['startDuration']} - ${edu['endDuration']}',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.edit, color: Color(0xFFCCFF00), size: 20),
                    onPressed: () => _showEducationDialog(education: edu),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    onPressed: () => _showDeleteConfirmation(
                      context,
                      'Education',
                      () {
                        setState(() {
                          UserData.education.remove(edu);
                        });
                        _showSectionDetails('Education');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${edu['course']} - ${edu['specification']}',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFFCCFF00),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'University: ${edu['university']}\n' +
            'Course Type: ${edu['courseType']}\n' +
            '${edu['gradingSystem']}: ${edu['marks']}',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(Map<String, String> lang) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lang.keys.first,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFCCFF00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  lang.values.first,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFFCCFF00),
                    fontSize: 14,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.edit, color: Color(0xFFCCFF00), size: 20),
                onPressed: () => _showLanguageDialog(language: lang),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => _showDeleteConfirmation(
                  context,
                  'Language',
                  () {
                    setState(() {
                      UserData.languages.remove(lang);
                    });
                    _showSectionDetails('Languages Known');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(Map<String, dynamic> cert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cert['title'] ?? '',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    cert['expiryDate'] ?? '',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.edit, color: Color(0xFFCCFF00), size: 20),
                    onPressed: () => _showCertificateDialog(certificate: cert),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    onPressed: () => _showDeleteConfirmation(
                      context,
                      'Certificate',
                      () {
                        setState(() {
                          UserData.certificates.remove(cert);
                        });
                        _showSectionDetails('Courses & Certificates');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            cert['issuer'] ?? '',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFFCCFF00),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          if (cert['url'] != null && cert['url'].isNotEmpty)
            Text(
              cert['url'],
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          if (cert['isExpired'] != null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: cert['isExpired'] == 'Yes' 
                  ? Colors.red.withOpacity(0.2) 
                  : Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                cert['isExpired'] == 'Yes' ? 'Expired' : 'Active',
                style: GoogleFonts.plusJakartaSans(
                  color: cert['isExpired'] == 'Yes' ? Colors.red : Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showEducationDialog({Map<String, dynamic>? education}) {
    final educationController = TextEditingController(text: education?['education']);
    final courseController = TextEditingController(text: education?['course']);
    final courseTypeController = TextEditingController(text: education?['courseType']);
    final specificationController = TextEditingController(text: education?['specification']);
    final universityController = TextEditingController(text: education?['university']);
    final startDurationController = TextEditingController(text: education?['startDuration']);
    final endDurationController = TextEditingController(text: education?['endDuration']);
    final marksController = TextEditingController(text: education?['marks']);
    String selectedGradingSystem = education?['gradingSystem'] ?? 'CGPA';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  education == null ? 'Add Education' : 'Edit Education',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                // Education Dropdown
                DropdownButtonFormField<String>(
                  value: education?['education'],
                  hint: Text('Select Education', 
                    style: GoogleFonts.plusJakartaSans(color: Colors.white54)),
                  items: ['B.Tech', 'M.Tech', 'BCA', 'MCA', 'BSc', 'MSc']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      educationController.text = newValue ?? '';
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: _getDropdownDecoration('Education'),
                ),
                const SizedBox(height: 12),
                // Course Dropdown
                DropdownButtonFormField<String>(
                  value: education?['course'],
                  hint: Text('Select Course', 
                    style: GoogleFonts.plusJakartaSans(color: Colors.white54)),
                  items: ['Computer Science', 'Information Technology', 'Electronics']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      courseController.text = newValue ?? '';
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: _getDropdownDecoration('Course'),
                ),
                const SizedBox(height: 12),
                // Course Type Dropdown
                DropdownButtonFormField<String>(
                  value: education?['courseType'],
                  hint: Text('Select Course Type', 
                    style: GoogleFonts.plusJakartaSans(color: Colors.white54)),
                  items: ['Full Time', 'Part Time', 'Distance Learning']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      courseTypeController.text = newValue ?? '';
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: _getDropdownDecoration('Course Type'),
                ),
                const SizedBox(height: 12),
                // Specification Dropdown
                DropdownButtonFormField<String>(
                  value: education?['specification'],
                  hint: Text('Select Specification', 
                    style: GoogleFonts.plusJakartaSans(color: Colors.white54)),
                  items: ['Software Engineering', 'Data Science', 'AI/ML']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      specificationController.text = newValue ?? '';
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: _getDropdownDecoration('Specification'),
                ),
                const SizedBox(height: 12),
                // University Dropdown
                DropdownButtonFormField<String>(
                  value: education?['university'],
                  hint: Text('Select University', 
                    style: GoogleFonts.plusJakartaSans(color: Colors.white54)),
                  items: ['University 1', 'University 2', 'University 3']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      universityController.text = newValue ?? '';
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: _getDropdownDecoration('University'),
                ),
                const SizedBox(height: 12),
                // Start Duration
                _buildTextField('Start Duration', startDurationController),
                const SizedBox(height: 12),
                // End Duration
                _buildTextField('End Duration', endDurationController),
                const SizedBox(height: 12),
                // Grading System Dropdown
                DropdownButtonFormField<String>(
                  value: selectedGradingSystem,
                  items: ['CGPA', 'Percentage', 'Grade']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGradingSystem = newValue!;
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: _getDropdownDecoration('Grading System'),
                ),
                const SizedBox(height: 12),
                // Marks Input
                _buildTextField('Enter Marks', marksController),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        final newEducation = {
                          'education': educationController.text,
                          'course': courseController.text,
                          'courseType': courseTypeController.text,
                          'specification': specificationController.text,
                          'university': universityController.text,
                          'startDuration': startDurationController.text,
                          'endDuration': endDurationController.text,
                          'gradingSystem': selectedGradingSystem,
                          'marks': marksController.text,
                        };
                        
                        setState(() {
                          if (education == null) {
                            UserData.education.add(newEducation);
                          } else {
                            final index = UserData.education.indexOf(education);
                            UserData.education[index] = newEducation;
                          }
                        });
                        Navigator.pop(context);
                        _showSectionDetails('Education');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCFF00),
                      ),
                      child: Text(
                        education == null ? 'Save' : 'Update',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog({Map<String, String>? language}) {
    final languageController = TextEditingController(
      text: language?.keys.first
    );
    String selectedProficiency = language?.values.first ?? 'Beginner';

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (BuildContext context, StateSetter dialogSetState) => Dialog(
          backgroundColor: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Languages Known',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(dialogContext),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTextField('Language', languageController),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedProficiency,
                  items: ['Beginner', 'Intermediate', 'Expert']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    dialogSetState(() {
                      selectedProficiency = newValue!;
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: _getDropdownDecoration('Proficiency'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCFF00),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (languageController.text.isNotEmpty) {
                        final newLanguage = {
                          languageController.text: selectedProficiency,
                        };
                        
                        setState(() {
                          if (language == null) {
                            UserData.languages.add(newLanguage);
                          } else {
                            final index = UserData.languages.indexOf(language);
                            UserData.languages[index] = newLanguage;
                          }
                        });
                        Navigator.pop(dialogContext);
                        _showSectionDetails('Languages Known');
                      }
                    },
                    child: Text(
                      'Save And Continue',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCertificateDialog({Map<String, dynamic>? certificate}) {
    final certificateNameController = TextEditingController(text: certificate?['title']);
    final certificateUrlController = TextEditingController(text: certificate?['url']);
    final issueByController = TextEditingController(text: certificate?['issuer']);
    final expiryDateController = TextEditingController(text: certificate?['expiryDate']);
    String? isCertificateExpired = certificate?['isExpired'];
    String? selectedFile = certificate?['certificateImage'];

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => StatefulBuilder(
        builder: (BuildContext context, StateSetter dialogSetState) => Dialog(
          backgroundColor: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          certificate == null ? 'Add Certificate' : 'Edit Certificate',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Certificate Name
                  _buildTextField(
                    'Certificate Name',
                    certificateNameController,
                    required: true,
                  ),
                  const SizedBox(height: 12),
                  // Certificate URL
                  _buildTextField(
                    'Certificate Url',
                    certificateUrlController,
                  ),
                  const SizedBox(height: 12),
                  // Issue By
                  _buildTextField(
                    'Issue By',
                    issueByController,
                    required: true,
                  ),
                  const SizedBox(height: 12),
                  // Is Certificate Expired
                  DropdownButtonFormField<String>(
                    value: isCertificateExpired,
                    hint: Text(
                      'Is Certificate Expired ?',
                      style: GoogleFonts.plusJakartaSans(color: Colors.white54),
                    ),
                    items: ['Yes', 'No'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.plusJakartaSans(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      dialogSetState(() {
                        isCertificateExpired = newValue;
                      });
                    },
                    style: GoogleFonts.plusJakartaSans(color: Colors.white),
                    dropdownColor: const Color(0xFF1C1C1E),
                    decoration: _getDropdownDecoration(''),
                  ),
                  const SizedBox(height: 12),
                  // Expiry Date
                  _buildTextField(
                    'Expiry Date',
                    expiryDateController,
                    required: true,
                  ),
                  const SizedBox(height: 16),
                  // Certificate Image
                  Text(
                    'Certificate Image',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StatefulBuilder(
                    builder: (context, setState) => GestureDetector(
                      onTap: () {
                        // TODO: Implement file picker
                        setState(() {
                          selectedFile = 'selected_file.pdf';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white24,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.file_upload_outlined,
                              color: Colors.white54,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              selectedFile ?? 'Choose File to upload',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Files Supported: PDF, JPG, PNG',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCFF00),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (certificateNameController.text.isNotEmpty &&
                            issueByController.text.isNotEmpty &&
                            expiryDateController.text.isNotEmpty) {
                          final newCertificate = {
                            'title': certificateNameController.text,
                            'url': certificateUrlController.text,
                            'issuer': issueByController.text,
                            'isExpired': isCertificateExpired,
                            'expiryDate': expiryDateController.text,
                            'certificateImage': selectedFile,
                          };
                          
                          setState(() {
                            if (certificate == null) {
                              UserData.certificates.add(newCertificate);
                            } else {
                              final index = UserData.certificates.indexOf(certificate);
                              UserData.certificates[index] = newCertificate;
                            }
                          });
                          Navigator.pop(dialogContext);
                          _showSectionDetails('Courses & Certificates');
                        }
                      },
                      child: Text(
                        certificate == null ? 'Save' : 'Update',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            if (required)
              Text(
                ' *',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: GoogleFonts.plusJakartaSans(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  InputDecoration _getDropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white70),
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String title, VoidCallback onDelete) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete $title?',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'This action cannot be undone.',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.plusJakartaSans(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onDelete();
                    },
                    child: Text(
                      'Delete',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 