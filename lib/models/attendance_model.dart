class AttendanceModel {
  final String id;
  final String date;
  final String checkIn;
  final String? checkOut;
  final DateTime createdAt;

  AttendanceModel({required this.id, required this.date, required this.checkIn, this.checkOut, required this.createdAt});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['employee_id'],
      date: json['date'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}