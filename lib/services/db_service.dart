import 'dart:math';

import 'package:employee_attendance/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DbService extends ChangeNotifier {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "faangFAANG1234567890";
    final randomString = List.generate(
        8, (index) => allChars[random.nextInt(allChars.length)]).join();

    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabaseClient.from(Constants.employeeTable).insert({
      'id': id,
      'name': '',
      'email': email,
      'employee_id': generateRandomEmployeeId(),
      'department': null,
    });
  }
}
