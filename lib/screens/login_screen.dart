import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/screens/login_instructions_screen.dart';
import 'package:rukedig/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  String _selectedLanguage = 'ID'; // Default to Indonesian

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Top Right: Language Selector
               Align(
                 alignment: Alignment.topRight,
                 child: Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                   decoration: BoxDecoration(
                     color: Colors.grey[100],
                     borderRadius: BorderRadius.circular(20),
                     border: Border.all(color: Colors.grey[300]!),
                   ),
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       _buildLanguageOption('ID'),
                       const SizedBox(width: 8),
                       Text('|', style: TextStyle(color: Colors.grey[400])),
                       const SizedBox(width: 8),
                       _buildLanguageOption('EN'),
                     ],
                   ),
                 ),
               ),
               const SizedBox(height: 80),
               
               // Welcome Text / Logo
               Center(
                 child: Text(
                   'Welcome Back',
                   style: GoogleFonts.playfairDisplay(
                     fontSize: 32,
                     color: const Color(0xFFFF9800), // Primary Orange
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
               const SizedBox(height: 8),
               Center(
                 child: Text(
                   'Sign in to continue learning',
                   style: GoogleFonts.poppins(
                     fontSize: 16,
                     color: Colors.grey[600],
                   ),
                 ),
               ),
               const SizedBox(height: 48),

               // Email Input
               _buildInputField(
                 label: 'Email 365',
                 icon: Icons.email_outlined,
                 hint: 'example@school.id',
               ),
               const SizedBox(height: 20),

               // Password Input
               _buildInputField(
                 label: 'Password',
                 icon: Icons.lock_outline,
                 isPassword: true,
                 isLast: true,
               ),
               const SizedBox(height: 32),

               // Login Button
               SizedBox(
                 width: double.infinity,
                 height: 56,
                 child: ElevatedButton(
                   onPressed: () {
                     // TODO: Form validation logic would go here
                     Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (_) => const HomeScreen()),
                     );
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Theme.of(context).primaryColor,
                     foregroundColor: Colors.white,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(16),
                     ),
                     elevation: 2,
                     shadowColor: Colors.orange.withOpacity(0.3),
                   ),
                   child: Text(
                     'Log In',
                     style: GoogleFonts.poppins(
                       fontSize: 18,
                       fontWeight: FontWeight.w600,
                       letterSpacing: 1,
                     ),
                   ),
                 ),
               ),
               
               const SizedBox(height: 40),
               
               // Help Link
               Center(
                 child: TextButton(
                   onPressed: () {
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (_) => LoginInstructionsScreen(initialLanguage: _selectedLanguage),
                       ),
                     );
                   },
                   child: Text(
                     'Butuh Bantuan?',
                     style: GoogleFonts.poppins(
                       color: const Color(0xFFFF9800), // Primary Orange
                       fontWeight: FontWeight.w500,
                       decoration: TextDecoration.none,
                     ),
                   ),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code) {
    bool isSelected = _selectedLanguage == code;
    return GestureDetector(
      onTap: () => setState(() => _selectedLanguage = code),
      child: Text(
        code,
        style: GoogleFonts.poppins(
          color: isSelected ? const Color(0xFFFF9800) : Colors.grey[400],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    String? hint,
    bool isPassword = false,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
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
            obscureText: isPassword && !_isPasswordVisible,
            textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
            style: GoogleFonts.poppins(color: Colors.black87),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
              prefixIcon: Icon(icon, color: Colors.orange[300]),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
