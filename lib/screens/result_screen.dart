import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultsScreen extends StatefulWidget {
  final int studentId;

  const ResultsScreen({super.key, required this.studentId});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<dynamic> resultsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    final url = Uri.parse(
        'http://localhost/school_app/api/student/results/read.php?student_id=${widget.studentId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          resultsList = jsonData['results'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching results: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : resultsList.isEmpty
              ? const Center(child: Text('No result records found'))
              : ListView.builder(
                  itemCount: resultsList.length,
                  itemBuilder: (context, index) {
                    final result = resultsList[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(
                          result['status'] == 'Pass'
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: result['status'] == 'Pass'
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(result['semester']),
                        subtitle: Text(
                          "Total: ${result['total_marks']} | Obtained: ${result['marks_obtained']}\n"
                          "Percentage: ${result['percentage']}%",
                        ),
                        trailing: Text(
                          result['status'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: result['status'] == 'Pass'
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
