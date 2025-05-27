import 'package:flutter/material.dart';
import 'package:school_app/screens/admin_screen/fees_overview_screen.dart';
import 'package:school_app/screens/admin_screen/reports_screen.dart';
import 'package:school_app/screens/admin_screen/roles_screen.dart';
import 'package:school_app/screens/admin_screen/settings_screen.dart';
import 'package:school_app/screens/admin_screen/users_screen.dart';


class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildDashboardTile(context, Icons.people, 'Users', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UsersScreen()),
              );
            }),
            _buildDashboardTile(context, Icons.person_outline, 'Roles', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RolesScreen()),
              );
            }),
            _buildDashboardTile(context, Icons.money, 'Fees Overview', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeesOverviewScreen()),
              );
            }),
            _buildDashboardTile(context, Icons.bar_chart, 'Reports', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportsScreen()),
              );
            }),
            _buildDashboardTile(context, Icons.settings, 'Settings', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            }),
            _buildDashboardTile(context, Icons.logout, 'Logout', () {
              _confirmLogout(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Material(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login page and clear history so user can't go back
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
