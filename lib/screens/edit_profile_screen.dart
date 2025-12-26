import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/models/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

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
  String? _selectedImagePath;
  XFile? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.currentProfile.firstName);
    _lastNameController = TextEditingController(text: widget.currentProfile.lastName);
    _emailController = TextEditingController(text: widget.currentProfile.email);
    _countryController = TextEditingController(text: widget.currentProfile.country);
    _descriptionController = TextEditingController(text: widget.currentProfile.description);
    _selectedImagePath = widget.currentProfile.profileImagePath;
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

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _selectedImageFile = image;
          _selectedImagePath = image.path;
        });
        
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto berhasil dipilih!'),
              backgroundColor: Color(0xFFFF9800),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih foto: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Widget _buildProfileImage() {
    if (_selectedImageFile != null) {
      // For web, use Network.image with the file path
      if (kIsWeb) {
        return CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(_selectedImageFile!.path),
        );
      } else {
        // For mobile, use FileImage
        return CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey,
          backgroundImage: FileImage(File(_selectedImageFile!.path)),
        );
      }
    } else if (_selectedImagePath != null) {
      if (_selectedImagePath!.startsWith('assets/')) {
        return CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage(_selectedImagePath!),
        );
      } else if (_selectedImagePath!.startsWith('http')) {
        return CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(_selectedImagePath!),
        );
      } else {
        return CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey,
          backgroundImage: kIsWeb 
              ? NetworkImage(_selectedImagePath!)
              : FileImage(File(_selectedImagePath!)) as ImageProvider,
        );
      }
    }
    return const CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey,
      backgroundImage: AssetImage('assets/images/ab.jpeg'),
    );
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
            // Profile Photo Section
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFF9800), width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: _buildProfileImage(),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9800),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library, color: Color(0xFFFF9800)),
              label: Text(
                'Ubah Foto',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFF9800),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 24),
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
                    profileImagePath: _selectedImagePath,
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
