import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> createStudent({
  required String name,
  required String email,
  required String password,
  required String rollNo,
  required String studentClass,
  int? parentId,
}) async {
  final url = Uri.parse('http://localhost/school_app/api/student/create.php');

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "name": name,
      "email": email,
      "password": password,
      "roll_no": rollNo,
      "class": studentClass,
      "parent_id": parentId,
    }),
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse['success']) {
      print('Student created successfully!');
    } else {
      print('Failed to create student: ${jsonResponse['message']}');
    }
  } else {
    print('Server error: ${response.statusCode}');
  }
}
