import 'package:flutter/material.dart';
import 'screens/parent_screen/parent_results_screen.dart';
import 'screens/parent_screen/parent_attendance_screen.dart';
import 'screens/parent_screen/parent_chat_screen.dart';

class ParentPage extends StatelessWidget {
  const ParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            DashboardCard(
              title: 'Results',
              icon: Icons.assignment,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ParentResultsScreen())),
            ),
            DashboardCard(
              title: 'Attendance',
              icon: Icons.check_circle_outline,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ParentAttendanceScreen())),
            ),
            DashboardCard(
              title: 'Chat',
              icon: Icons.chat,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ParentChatScreen())),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.teal),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
