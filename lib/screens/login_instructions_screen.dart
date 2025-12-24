import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginInstructionsScreen extends StatefulWidget {
  final String initialLanguage;
  const LoginInstructionsScreen({super.key, this.initialLanguage = 'ID'});

  @override
  State<LoginInstructionsScreen> createState() => _LoginInstructionsScreenState();
}

class _LoginInstructionsScreenState extends State<LoginInstructionsScreen> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final isId = _selectedLanguage == 'ID';
    final content = isId ? _contentID : _contentEN;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9800),
        elevation: 0,
        title: Text(
          isId ? 'Instruksi Login' : 'Login Instructions',
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white60),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLanguageToggle('ID'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('|', style: TextStyle(color: Colors.white70)),
                    ),
                    _buildLanguageToggle('EN'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildInfoCard(
              title: isId ? 'Pernyataan Akses' : 'Access Statement',
              content: content['access']!,
              icon: Icons.school,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: isId ? 'Panduan Akun' : 'Account Guide',
              content: content['account']!,
              icon: Icons.account_circle,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: isId ? 'Format Login' : 'Login Format',
              content: content['format']!,
              icon: Icons.edit_note,
              isMonospace: true,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: isId ? 'Catatan Keamanan' : 'Security Note',
              content: content['security']!,
              icon: Icons.security,
              isWarning: true,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: isId ? 'Kontak Bantuan' : 'Help Contact',
              content: content['contact']!,
              icon: Icons.headset_mic,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(String code) {
    final isSelected = _selectedLanguage == code;
    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = code),
      child: Text(
        code,
        style: GoogleFonts.poppins(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
    bool isMonospace = false,
    bool isWarning = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isWarning ? Colors.red.withOpacity(0.3) : Colors.grey[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isWarning ? Colors.red[400] : const Color(0xFFFF9800),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: isMonospace
                ? GoogleFonts.robotoMono(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  )
                : GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
          ),
        ],
      ),
    );
  }

  static const Map<String, String> _contentID = {
    'access': 'Akses terbatas hanya untuk Dosen dan Mahasiswa.',
    'account': 'Login menggunakan akun Microsoft Office 365.',
    'format': 'Username: Akun iGracias ditambahkan "@365.rukedig.ac.id"\nPassword: Password akun iGracias',
    'security': 'Kegagalan otentikasi biasanya karena belum mengubah kata sandi menjadi "Strong Password" di iGracias.',
    'contact': 'CeLOE Helpdesk via Email (info@rukedig.ac.id) atau WhatsApp (+62821-1666-3563).',
  };

  static const Map<String, String> _contentEN = {
    'access': 'Access limited to Lecturers and Students only.',
    'account': 'Login using Microsoft Office 365 account.',
    'format': 'Username: iGracias account appended with "@365.rukedig.ac.id"\nPassword: iGracias account password',
    'security': 'Authentication failure is usually due to not changing the password to "Strong Password" in iGracias.',
    'contact': 'CeLOE Helpdesk via Email (info@rukedig.ac.id) or WhatsApp (+62821-1666-3563).',
  };
}
