import 'package:flutter/material.dart';
import 'package:school_app/screens/hod_screen/approve_leaves_screen.dart';
import 'package:school_app/screens/hod_screen/view_reports_screen.dart';
import 'package:school_app/screens/hod_screen/chat_screen.dart';
import 'package:school_app/screens/hod_screen/manage_timetable_screen.dart';
import 'package:school_app/screens/hod_screen/staff_attendance_screen.dart';
import 'package:school_app/screens/hod_screen/salary_overview_screen.dart';

class HodPrincipalPage extends StatelessWidget {
  const HodPrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOD/Principal Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            DashboardCard(
              title: 'Approve Leaves',
              icon: Icons.check_circle,
              color: Colors.teal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ApproveLeavesScreen()),
              ),
            ),
            DashboardCard(
              title: 'View Reports',
              icon: Icons.bar_chart,
              color: Colors.orangeAccent,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ViewReportsScreen()),
              ),
            ),
            DashboardCard(
              title: 'Chat',
              icon: Icons.chat,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              ),
            ),
            DashboardCard(
              title: 'Manage Timetable',
              icon: Icons.schedule,
              color: Colors.indigo,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ManageTimetableScreen()),
              ),
            ),
            DashboardCard(
              title: 'Staff Attendance',
              icon: Icons.assignment_turned_in,
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StaffAttendanceScreen()),
              ),
            ),
            DashboardCard(
              title: 'Salary Overview',
              icon: Icons.attach_money,
              color: Colors.deepOrange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SalaryOverviewScreen()),
              ),
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
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
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
}
