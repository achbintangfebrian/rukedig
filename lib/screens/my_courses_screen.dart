import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kelas Saya',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          _buildCourseCard(
            title: 'Dasar Pemrograman',
            code: 'CS101',
            schedule: 'Senin, 08:00 - 10:00',
            progress: 0.7,
          ),
          const SizedBox(height: 16),
          _buildCourseCard(
            title: 'Kalkulus 1',
            code: 'MATH101',
            schedule: 'Rabu, 13:00 - 15:00',
            progress: 0.4,
          ),
          const SizedBox(height: 16),
          _buildCourseCard(
            title: 'Bahasa Inggris',
            code: 'LANG101',
            schedule: 'Jumat, 09:00 - 11:00',
            progress: 0.9,
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String code,
    required String schedule,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      code,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFFFF9800),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.book, color: Colors.orange[200]),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            schedule,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[100],
            color: const Color(0xFFFF9800),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }
}
