import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/models/user_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile currentProfile;

  const EditProfileScreen({super.key, required this.currentProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _countryController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.currentProfile.firstName);
    _lastNameController = TextEditingController(text: widget.currentProfile.lastName);
    _emailController = TextEditingController(text: widget.currentProfile.email);
    _countryController = TextEditingController(text: widget.currentProfile.country);
    _descriptionController = TextEditingController(text: widget.currentProfile.description);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Ubah Profil',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF9800),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildTextField(label: 'Nama Pertama', controller: _firstNameController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Nama Terakhir', controller: _lastNameController),
            const SizedBox(height: 16),
            _buildTextField(label: 'E-mail Address', controller: _emailController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Negara', controller: _countryController),
            const SizedBox(height: 16),
            _buildTextField(label: 'Deskripsi', controller: _descriptionController, maxLines: 4),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  final updatedProfile = UserProfile(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    country: _countryController.text,
                    description: _descriptionController.text,
                  );
                  Navigator.pop(context, updatedProfile);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.poppins(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
