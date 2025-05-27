import 'package:flutter/material.dart';
import 'screens/teacher_screen/teacher_attendance_screen.dart';
import 'screens/teacher_screen/teacher_upload_notes_screen.dart';
import 'screens/teacher_screen/teacher_chat_screen.dart';
import 'screens/teacher_screen/teacher_timetable_screen.dart';

class TeacherPage extends StatelessWidget {
  const TeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildDashboardCard({
      required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap,
    }) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        color: color,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: Colors.white),
                const SizedBox(height: 15),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: [
            buildDashboardCard(
              icon: Icons.check_box,
              label: 'Take Attendance',
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TeacherAttendanceScreen(),
                  ),
                );
              },
            ),
            buildDashboardCard(
              icon: Icons.upload_file,
              label: 'Upload Notes / Lectures',
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TeacherUploadNotesScreen(),
                  ),
                );
              },
            ),
            buildDashboardCard(
              icon: Icons.chat,
              label: 'Chat with Students / Parents',
              color: Colors.deepOrange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TeacherChatScreen(),
                  ),
                );
              },
            ),
            buildDashboardCard(
              icon: Icons.schedule,
              label: 'View Timetable',
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TeacherTimetableScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
