class Attendance {
  final int id;
  final String date;
  final int period;
  final String subject;
  final String status;

  Attendance({required this.id, required this.date, required this.period, required this.subject, required this.status});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      date: json['date'],
      period: json['period'],
      subject: json['subject'],
      status: json['status'],
    );
  }
}
