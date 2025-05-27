import 'package:flutter/material.dart';
import 'screens/staff_screen/upload_notes_screen.dart';
import 'screens/staff_screen/upload_lectures_screen.dart';
import 'screens/staff_screen/chat_screen.dart';
import 'screens/staff_screen/timetable_screen.dart';
import 'screens/staff_screen/salary_details_screen.dart';
import 'screens/staff_screen/leave_request_screen.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

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
                Icon(icon, size: 48, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
        centerTitle: true,
        //backgroundColor: Colors.deepPurple,
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
              icon: Icons.note_add,
              label: 'Upload Notes',
              color: Colors.indigo,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadNotesScreen()),
              ),
            ),
            buildDashboardCard(
              icon: Icons.video_library,
              label: 'Upload Lectures',
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UploadLecturesScreen()),
              ),
            ),
            buildDashboardCard(
              icon: Icons.chat,
              label: 'Chat',
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              ),
            ),
            buildDashboardCard(
              icon: Icons.calendar_today,
              label: 'Timetable',
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TimetableScreen()),
              ),
            ),
            buildDashboardCard(
              icon: Icons.monetization_on,
              label: 'Salary Details',
              color: Colors.teal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SalaryDetailsScreen()),
              ),
            ),
            buildDashboardCard(
              icon: Icons.beach_access,
              label: 'Leave Request',
              color: Colors.redAccent,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LeaveRequestScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
