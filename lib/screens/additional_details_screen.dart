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
        return UserData.education.map((edu) => _buildDetailCard(
          edu['education'] ?? '',
          '${edu['course']} - ${edu['specification']}',
          '${edu['startDuration']} - ${edu['endDuration']}',
          'University: ${edu['university']}\n' +
          'Course Type: ${edu['courseType']}\n' +
          '${edu['gradingSystem']}: ${edu['marks']}',
        )).toList();
      case 'Languages Known':
        return UserData.languages.map((lang) => _buildLanguageCard(
          lang.keys.first,
          lang.values.first,
        )).toList();
      case 'Courses & Certificates':
        return UserData.certificates.map((cert) => _buildCertificateCard(cert)).toList();
      default:
        return [];
    }
  }

  Widget _buildDetailCard(String title, String subtitle, String duration, String description) {
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
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                duration,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFFCCFF00),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(String language, String proficiency) {
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
            language,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFCCFF00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              proficiency,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFCCFF00),
                fontSize: 14,
              ),
            ),
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
              Text(
                cert['expiryDate'] ?? '',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white54,
                  fontSize: 14,
                ),
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

  void _showEducationDialog() {
    final educationController = TextEditingController();
    final courseController = TextEditingController();
    final courseTypeController = TextEditingController();
    final specificationController = TextEditingController();
    final universityController = TextEditingController();
    final startDurationController = TextEditingController();
    final endDurationController = TextEditingController();
    final marksController = TextEditingController();
    String selectedGradingSystem = 'CGPA';

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
                  'Add Education',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                // Education Dropdown
                DropdownButtonFormField<String>(
                  value: null,
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
                  value: null,
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
                  value: null,
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
                  value: null,
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
                  value: null,
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
                        setState(() {
                          UserData.education.add({
                            'education': educationController.text,
                            'course': courseController.text,
                            'courseType': courseTypeController.text,
                            'specification': specificationController.text,
                            'university': universityController.text,
                            'startDuration': startDurationController.text,
                            'endDuration': endDurationController.text,
                            'gradingSystem': selectedGradingSystem,
                            'marks': marksController.text,
                          });
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCFF00),
                      ),
                      child: Text(
                        'Save',
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

  void _showLanguageDialog() {
    final languageController = TextEditingController();
    String selectedProficiency = 'Beginner';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: const Color(0xFF1C1C1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Language',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
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
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedProficiency = newValue!;
                    });
                  },
                  style: GoogleFonts.plusJakartaSans(color: Colors.white),
                  dropdownColor: const Color(0xFF1C1C1E),
                  decoration: InputDecoration(
                    labelText: 'Proficiency',
                    labelStyle: GoogleFonts.plusJakartaSans(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
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
                      onPressed: () {
                        setState(() {
                          UserData.languages.add({
                            languageController.text: selectedProficiency,
                          });
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCCFF00),
                      ),
                      child: Text(
                        'Save',
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

  void _showCertificateDialog() {
    final certificateNameController = TextEditingController();
    final certificateUrlController = TextEditingController();
    final issueByController = TextEditingController();
    final expiryDateController = TextEditingController();
    String? isCertificateExpired;
    String? selectedFile;

    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                        'Add Courses & Certificate',
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
                      onPressed: () => Navigator.pop(context),
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
                StatefulBuilder(
                  builder: (context, setState) => DropdownButtonFormField<String>(
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
                      setState(() {
                        isCertificateExpired = newValue;
                      });
                    },
                    style: GoogleFonts.plusJakartaSans(color: Colors.white),
                    dropdownColor: const Color(0xFF1C1C1E),
                    decoration: _getDropdownDecoration(''),
                  ),
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
                    onPressed: () {
                      if (certificateNameController.text.isNotEmpty &&
                          issueByController.text.isNotEmpty &&
                          expiryDateController.text.isNotEmpty) {
                        setState(() {
                          UserData.certificates.add({
                            'title': certificateNameController.text,
                            'url': certificateUrlController.text,
                            'issuer': issueByController.text,
                            'isExpired': isCertificateExpired,
                            'expiryDate': expiryDateController.text,
                            'certificateImage': selectedFile,
                          });
                        });
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCCFF00),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
} 