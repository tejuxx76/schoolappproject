import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeesScreen extends StatefulWidget {
  final int studentId;

  const FeesScreen({super.key, required this.studentId});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  List<dynamic> feesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFees();
  }

  Future<void> fetchFees() async {
    final url = Uri.parse(
        'http://localhost/school_app/api/student/fees/read.php?student_id=${widget.studentId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          feesList = jsonData['fees'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load fees');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching fees: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fee Details')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : feesList.isEmpty
              ? const Center(child: Text('No fee records found'))
              : ListView.builder(
                  itemCount: feesList.length,
                  itemBuilder: (context, index) {
                    final fee = feesList[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(
                          fee['status'] == 'Paid'
                              ? Icons.check_circle
                              : Icons.error,
                          color: fee['status'] == 'Paid'
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(fee['semester']),
                        subtitle: Text(
                            "Amount: ₹${fee['amount']}\nDue Date: ${fee['due_date']}"),
                        trailing: Text(
                          fee['status'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: fee['status'] == 'Paid'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
