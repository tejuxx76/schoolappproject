import 'package:flutter/material.dart';
import 'screens/management_screen/college_overview_screen.dart';
import 'screens/management_screen/management_fee_screen.dart';
import 'screens/management_screen/management_salary_screen.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Management Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            DashboardCard(
              title: 'Fee Details',
              icon: Icons.attach_money,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManagementFeeScreen())),
            ),
            DashboardCard(
              title: 'Salary Overview',
              icon: Icons.money,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManagementSalaryScreen())),
            ),
            DashboardCard(
              title: 'College Overview',
              icon: Icons.school,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CollegeOverviewScreen())),
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
              Icon(icon, size: 48, color: Colors.blueAccent),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
