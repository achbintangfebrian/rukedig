import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/screens/announcement_detail_screen.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final announcements = [
      {
        'title': 'Maintenance Pra UAS Semester Genap 2025/2026',
        'date': '10 Januari 2026',
        'type': 'PENTING',
        'description': 'Sistem akan mengalami maintenance untuk persiapan UAS Semester Genap 2025/2026.',
        'purpose': 'Meningkatkan layanan server untuk menghadapi Ujian Akhir Semester (UAS).',
        'timeRange': '10 Januari 2026, pukul 00.00 s/d 06.00 WIB',
        'impact': 'Situs LMS tidak dapat diakses selama periode tersebut.',
      },
      {
        'title': 'Pengumuman Maintenance',
        'date': '20 Januari 2026',
        'type': 'INFO',
        'description': 'Maintenance terjadwal untuk peningkatan sistem.',
        'purpose': 'Peningkatan infrastruktur server dan keamanan sistem.',
        'timeRange': '20 Januari 2026, pukul 01.00 s/d 05.00 WIB',
        'impact': 'Beberapa fitur mungkin tidak tersedia sementara.',
      },
      {
        'title': 'Maintenance Pra UAS Semester Ganjil 2025/2026',
        'date': '20 Januari 2026',
        'type': 'PENTING',
        'description': 'Sistem akan mengalami maintenance untuk persiapan UAS Semester Ganjil 2025/2026.',
        'purpose': 'Optimalisasi database dan server untuk UAS Semester Ganjil.',
        'timeRange': '20 Januari 2026, pukul 00.00 s/d 08.00 WIB',
        'impact': 'Seluruh sistem LMS tidak dapat diakses.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pengumuman',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF9800),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: announcements.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final announcement = announcements[index];
                return _buildAnnouncementCard(
                  context: context,
                  title: announcement['title'] as String,
                  date: announcement['date'] as String,
                  type: announcement['type'] as String,
                  description: announcement['description'] as String,
                  purpose: announcement['purpose'] as String,
                  timeRange: announcement['timeRange'] as String,
                  impact: announcement['impact'] as String,
                );
              },
            ),
    );
  }

  Widget _buildAnnouncementCard({
    required BuildContext context,
    required String title,
    required String date,
    required String type,
    required String description,
    required String purpose,
    required String timeRange,
    required String impact,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnnouncementDetailScreen(
              title: title,
              date: date,
              type: type,
              purpose: purpose,
              timeRange: timeRange,
              impact: impact,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: type == 'PENTING' 
                ? const Color(0xFFFF9800) 
                : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with badge and icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9800).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      type == 'PENTING' ? Icons.campaign : Icons.info_outline,
                      color: const Color(0xFFFF9800),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: type == 'PENTING'
                                ? const Color(0xFFFF9800)
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            type,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    date,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              // Description
              Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              // View details indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Lihat Detail',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFFFF9800),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Color(0xFFFF9800),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.campaign_outlined,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada pengumuman',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
