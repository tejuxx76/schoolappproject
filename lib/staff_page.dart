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
    // Helper function for card creation
    Widget buildCard({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: Colors.deepPurple.withAlpha(30),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: color ?? Colors.deepPurple),
                const SizedBox(height: 15),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildCard(
              icon: Icons.note_add,
              title: 'Upload Notes',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadNotesScreen())),
            ),
            buildCard(
              icon: Icons.video_library,
              title: 'Upload Lectures',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UploadLecturesScreen())),
            ),
            buildCard(
              icon: Icons.chat,
              title: 'Chat',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
            ),
            buildCard(
              icon: Icons.calendar_today,
              title: 'Timetable',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TimetableScreen())),
            ),
            buildCard(
              icon: Icons.monetization_on,
              title: 'Salary Details',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SalaryDetailsScreen())),
            ),
            buildCard(
              icon: Icons.beach_access,
              title: 'Leave Request',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveRequestScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
