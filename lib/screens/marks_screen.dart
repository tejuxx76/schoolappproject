import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarksScreen extends StatefulWidget {
  final int studentId;

  const MarksScreen({super.key, required this.studentId});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  List<dynamic> marksList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMarks();
  }

  Future<void> fetchMarks() async {
    final url = Uri.parse(
        'http://localhost/school_app/api/student/marks/read.php?student_id=${widget.studentId}');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        setState(() {
          marksList = jsonData['marks'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load marks");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching marks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marks')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : marksList.isEmpty
              ? const Center(child: Text("No marks available"))
              : ListView.builder(
                  itemCount: marksList.length,
                  itemBuilder: (context, index) {
                    final item = marksList[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(item['subject'] ?? ''),
                        subtitle: Text(
                            "${item['exam_type']} - ${item['marks_obtained']}/${item['total_marks']}"),
                        trailing: Text(item['exam_date'] ?? ''),
                      ),
                    );
                  },
                ),
    );
  }
}
