import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignmentStatusScreen extends StatelessWidget {
  final String assignmentTitle;
  final String submittedFileName;
  final String submissionTime;
  final String deadline;
  final bool isGraded;
  final int? score;

  const AssignmentStatusScreen({
    super.key,
    required this.assignmentTitle,
    required this.submittedFileName,
    required this.submissionTime,
    required this.deadline,
    this.isGraded = false,
    this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Status Pengumpulan',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF9800),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildStatusCards(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF9800),
            const Color(0xFFFF9800).withOpacity(0.8),
          ],
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 64,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            'Tugas Berhasil Dikumpulkan!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            assignmentTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Submission Status
          _buildStatusCard(
            icon: Icons.upload_file,
            iconColor: Colors.green,
            title: 'Status Pengumpulan',
            mainText: 'Sudah Dikirim',
            subtitle: submissionTime,
            backgroundColor: Colors.green[50]!,
            borderColor: Colors.green,
          ),
          const SizedBox(height: 16),

          // Grading Status
          _buildStatusCard(
            icon: isGraded ? Icons.grade : Icons.pending,
            iconColor: isGraded ? Colors.blue : Colors.grey,
            title: 'Status Penilaian',
            mainText: isGraded ? 'Sudah Dinilai' : 'Belum Dinilai',
            subtitle: isGraded && score != null ? 'Nilai: $score' : 'Menunggu penilaian dosen',
            backgroundColor: isGraded ? Colors.blue[50]! : Colors.grey[100]!,
            borderColor: isGraded ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 16),

          // File Info
          _buildFileInfoCard(),
          const SizedBox(height: 16),

          // Timing Info
          _buildTimingCard(),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String mainText,
    required String subtitle,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  mainText,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFF9800), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text(
                'File yang Dikirim',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.picture_as_pdf, color: Colors.red[600], size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        submittedFileName,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'PDF Document',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.visibility, color: const Color(0xFFFF9800)),
                  onPressed: () {
                    // View file action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimingCard() {
    // Calculate time remaining (simplified)
    final deadlineDate = DateTime.parse('2026-01-01 23:59'); // Example
    final now = DateTime.now();
    final isLate = now.isAfter(deadlineDate);
    final difference = deadlineDate.difference(now);
    
    final remainingText = isLate 
        ? 'Terlambat ${difference.inDays.abs()} hari'
        : 'Sisa waktu: ${difference.inDays} hari';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTimingRow(
            icon: Icons.access_time,
            label: 'Waktu Pengumpulan',
            value: submissionTime,
          ),
          const Divider(height: 24),
          _buildTimingRow(
            icon: Icons.event,
            label: 'Batas Waktu',
            value: deadline,
          ),
          const Divider(height: 24),
          _buildTimingRow(
            icon: Icons.timer,
            label: 'Informasi',
            value: remainingText,
            valueColor: isLate ? Colors.red : Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildTimingRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFFFF9800)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
