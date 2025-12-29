import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukedig/screens/assignment_submission_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseName;
  final String courseCode;
  final String instructor;
  final String semester;
  final double progress;

  const CourseDetailScreen({
    super.key,
    required this.courseName,
    required this.courseCode,
    required this.instructor,
    required this.semester,
    required this.progress,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  // Track submitted assignments
  final Set<String> _submittedAssignments = {};

  void _markAsSubmitted(String assignmentTitle) {
    setState(() {
      _submittedAssignments.add(assignmentTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Detail Kelas',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            _buildHeader(),
            
            // Description Section
            _buildSection(
              title: 'Deskripsi Mata Kuliah',
              child: _buildDescription(),
            ),
            
            // Learning Method
            _buildSection(
              title: 'Metode Pembelajaran',
              child: _buildLearningMethod(),
            ),
            
            // Weekly Sessions (NEW)
            _buildSection(
              title: 'Pertemuan Mingguan',
              child: _buildWeeklySessions(),
            ),
            
            // Materials
            _buildSection(
              title: 'Materi Pembelajaran',
              child: _buildMaterials(),
            ),
            
            // Assignments
            _buildSection(
              title: 'Tugas',
              child: _buildAssignments(),
            ),
            
            // Quizzes
            _buildSection(
              title: 'Kuis',
              child: _buildQuizzes(),
            ),
            
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.courseCode,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF9800),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.courseName,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.instructor,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(
                widget.semester,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'Mata kuliah ini mempelajari konsep-konsep fundamental tentang ${widget.courseName}, '
        'termasuk teori, praktik, dan implementasi. Mahasiswa akan dibekali dengan '
        'pengetahuan dan keterampilan yang diperlukan untuk menguasai bidang ini.',
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey[700],
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildLearningMethod() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF9800), width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.video_call, color: Colors.blue, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zoom Meeting Synchronous',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pembelajaran tatap muka virtual',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.open_in_new, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildWeeklySessions() {
    final sessions = [
      {
        'week': 1,
        'title': 'Pengenalan ${widget.courseName}',
        'materials': ['Pengantar dan konsep dasar'],
        'urls': ['https://zoom.us/meeting/pertemuan-1', 'https://docs.google.com/slides'],
        'files': ['Modul_1.pdf', 'Materi_Week1.pptx'],
        'quiz': 'Quiz 1 - Pengenalan',
        'assignment': 'Tugas 1 - Essay'
      },
      {
        'week': 2,
        'title': 'Konsep Fundamental',
        'materials': ['Teori dan praktik fundamental'],
        'urls': ['https://zoom.us/meeting/pertemuan-2'],
        'files': ['Modul_2.pdf'],
        'quiz': null,
        'assignment': 'Tugas 2 - Analisis'
      },
      {
        'week': 3,
        'title': 'Implementasi Dasar',
        'materials': ['Praktik implementasi'],
        'urls': ['https://zoom.us/meeting/pertemuan-3', 'https://github.com/demo'],
        'files': ['Modul_3.pdf', 'Source_Code.zip'],
        'quiz': 'Quiz 2 - Implementasi',
        'assignment': null
      },
      {
        'week': 4,
        'title': 'Studi Kasus',
        'materials': ['Analisis studi kasus nyata'],
        'urls': ['https://zoom.us/meeting/pertemuan-4'],
        'files': ['CaseStudy.pdf'],
        'quiz': null,
        'assignment': 'Tugas 3 - Studi Kasus'
      },
      {
        'week': 5,
        'title': 'Aplikasi Lanjutan',
        'materials': ['Implementasi advanced'],
        'urls': ['https://zoom.us/meeting/pertemuan-5'],
        'files': ['Modul_5.pdf', 'Advanced_Materials.pdf'],
        'quiz': 'Quiz 3 - Advanced',
        'assignment': 'Tugas 4 - Project'
      },
      {
        'week': 6,
        'title': 'Review dan Evaluasi',
        'materials': ['Review materi keseluruhan'],
        'urls': ['https://zoom.us/meeting/pertemuan-6'],
        'files': ['Review_Final.pdf'],
        'quiz': 'Quiz Final',
        'assignment': 'Final Project'
      },
    ];

    return WeeklySessionsList(sessions: sessions);
  }

  Widget _buildMaterials() {
    final materials = [
      {'type': 'PDF', 'title': 'Modul 1 - Pengenalan', 'icon': Icons.picture_as_pdf, 'color': Colors.red},
      {'type': 'Video', 'title': 'Video Tutorial Week 1', 'icon': Icons.play_circle, 'color': Colors.blue},
      {'type': 'URL', 'title': 'Referensi Online', 'icon': Icons.link, 'color': Colors.green},
      {'type': 'PDF', 'title': 'Modul 2 - Lanjutan', 'icon': Icons.picture_as_pdf, 'color': Colors.red},
    ];

    return Column(
      children: materials.map((material) {
        return _buildMaterialItem(
          icon: material['icon'] as IconData,
          color: material['color'] as Color,
          title: material['title'] as String,
          type: material['type'] as String,
        );
      }).toList(),
    );
  }

  Widget _buildMaterialItem({
    required IconData icon,
    required Color color,
    required String title,
    required String type,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  type,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.download, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildAssignments() {
    final assignments = [
      {'title': 'Tugas 1 - Essay', 'dueDate': '1 Jan 2026', 'status': 'done'},
      {'title': 'Tugas 2 - Presentasi', 'dueDate': '8 Jan 2026', 'status': 'pending'},
      {'title': 'Tugas 3 - Project', 'dueDate': '15 Jan 2026', 'status': 'upcoming'},
    ];

    return Column(
      children: assignments.map((assignment) {
        final title = assignment['title'] as String;
        final originalStatus = assignment['status'] as String;
        
        // Override status if assignment was submitted
        final actualStatus = _submittedAssignments.contains(title) ? 'done' : originalStatus;
        
        return Builder(
          builder: (context) => _buildAssignmentItem(
            context: context,
            title: title,
            dueDate: assignment['dueDate'] as String,
            status: actualStatus,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAssignmentItem({
    required BuildContext context,
    required String title,
    required String dueDate,
    required String status,
  }) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case 'done':
        statusColor = Colors.green;
        statusText = 'Selesai';
        statusIcon = Icons.check_circle;
        break;
      case 'pending':
        statusColor = Colors.orange;
        statusText = 'Dikerjakan';
        statusIcon = Icons.pending;
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Belum Mulai';
        statusIcon = Icons.schedule;
    }

    return InkWell(
      onTap: () async {
        // Navigate and wait for result
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AssignmentSubmissionScreen(
              assignmentTitle: title,
              dueDate: dueDate,
              status: status,
            ),
          ),
        );
        
        // If submission was successful, mark as submitted
        if (result == true) {
          _markAsSubmitted(title);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: statusColor.withOpacity(0.3)),
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
            Icon(Icons.assignment, color: const Color(0xFFFF9800), size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 12, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Deadline: $dueDate',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(statusIcon, size: 14, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    statusText,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizzes() {
    final quizzes = [
      {'title': 'Quiz 1 - Multiple Choice', 'schedule': '5 Jan 2026, 10:00', 'duration': '30 menit'},
      {'title': 'Quiz 2 - Essay', 'schedule': '12 Jan 2026, 10:00', 'duration': '45 menit'},
    ];

    return Column(
      children: quizzes.map((quiz) {
        return _buildQuizItem(
          title: quiz['title'] as String,
          schedule: quiz['schedule'] as String,
          duration: quiz['duration'] as String,
        );
      }).toList(),
    );
  }

  Widget _buildQuizItem({
    required String title,
    required String schedule,
    required String duration,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.quiz, color: Colors.purple, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      schedule,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Text(
                  'Durasi: $duration',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }
}

// Weekly Sessions List Widget
class WeeklySessionsList extends StatefulWidget {
  final List<Map<String, dynamic>> sessions;

  const WeeklySessionsList({super.key, required this.sessions});

  @override
  State<WeeklySessionsList> createState() => _WeeklySessionsListState();
}

class _WeeklySessionsListState extends State<WeeklySessionsList> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.sessions.length, (index) {
        final session = widget.sessions[index];
        final isExpanded = _expandedIndex == index;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isExpanded ? const Color(0xFFFF9800) : Colors.grey[300]!,
              width: isExpanded ? 2 : 1,
            ),
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
              InkWell(
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? null : index;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isExpanded
                              ? const Color(0xFFFF9800)
                              : const Color(0xFFFF9800).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '${session['week']}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isExpanded ? Colors.white : const Color(0xFFFF9800),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pertemuan ${session['week']}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              session['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: const Color(0xFFFF9800),
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Materials
                      _buildSessionItem(
                        icon: Icons.description,
                        color: Colors.blue,
                        title: 'Materi',
                        items: session['materials'] as List<dynamic>,
                      ),
                      const SizedBox(height: 12),

                      // URLs
                      _buildSessionItem(
                        icon: Icons.link,
                        color: Colors.green,
                        title: 'URL',
                        items: session['urls'] as List<dynamic>,
                      ),
                      const SizedBox(height: 12),

                      // Files
                      _buildSessionItem(
                        icon: Icons.attach_file,
                        color: Colors.red,
                        title: 'File',
                        items: session['files'] as List<dynamic>,
                      ),

                      if (session['quiz'] != null) ...[
                        const SizedBox(height: 12),
                        _buildSessionBadge(
                          icon: Icons.quiz,
                          color: Colors.purple,
                          title: 'Kuis',
                          value: session['quiz'] as String,
                        ),
                      ],

                      if (session['assignment'] != null) ...[
                        const SizedBox(height: 12),
                        _buildSessionBadge(
                          icon: Icons.assignment,
                          color: Colors.orange,
                          title: 'Tugas',
                          value: session['assignment'] as String,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSessionItem({
    required IconData icon,
    required Color color,
    required String title,
    required List<dynamic> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 4),
            child: Row(
              children: [
                Icon(Icons.circle, size: 6, color: Colors.grey[400]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSessionBadge({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
