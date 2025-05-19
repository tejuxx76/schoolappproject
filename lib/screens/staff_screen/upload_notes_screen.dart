import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadNotesScreen extends StatefulWidget {
  const UploadNotesScreen({super.key});

  @override
  State<UploadNotesScreen> createState() => _UploadNotesScreenState();
}

class _UploadNotesScreenState extends State<UploadNotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  List<dynamic> notesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final url = Uri.parse('http://localhost/school_app/api/staff/notes/read.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          notesList = jsonData['notes'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching notes: $e");
    }
  }

  Future<void> uploadNote() async {
    final url = Uri.parse('http://localhost/school_app/api/staff/notes/create.php');
    try {
      final response = await http.post(url, body: {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'subject': _subjectController.text,
        'uploaded_by': '1', // Replace with dynamic staff_id later
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note uploaded successfully')),
          );
          _titleController.clear();
          _descriptionController.clear();
          _subjectController.clear();
          fetchNotes(); // refresh notes list
        } else {
          throw Exception(jsonData['message']);
        }
      } else {
        throw Exception('Failed to upload note');
      }
    } catch (e) {
      print("Upload error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Notes')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: uploadNote,
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Upload Note'),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 10),
            const Text('Uploaded Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : notesList.isEmpty
                    ? const Text('No notes uploaded yet.')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notesList.length,
                        itemBuilder: (context, index) {
                          final note = notesList[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: const Icon(Icons.description, color: Colors.blue),
                              title: Text(note['title']),
                              subtitle: Text(
                                "Subject: ${note['subject']}\n${note['description']}",
                              ),
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
