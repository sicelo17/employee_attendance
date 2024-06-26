import 'package:employee_attendance/services/db_service.dart';
import 'package:employee_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final DbService _dbService = DbService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future registerEmployee(String email, String password, BuildContext context) async {
  setIsLoading = true;
  try {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("All fields are required");
    }

    final AuthResponse response = await _supabaseClient.auth.signUp(email: email, password: password);
    if (response.user != null) {
      await _dbService.insertNewUser(email, response.user!.id);

      Utils.showSnackBar("Successfully registered.", context, color: Colors.green);

      await loginEmployee(email, password, context);
      Navigator.pop(context);
    } else {
      throw Exception("Failed to register user.");
    }
  } catch (e) {
    Utils.showSnackBar(e.toString(), context, color: Colors.red);
  } finally {
    setIsLoading = false;
  }
}

  Future loginEmployee(
      String email, String password, BuildContext context) async {
    try {
      setIsLoading = true;
      if (email == "" || password == "") {
        throw ("All fields are required");
      }

      final AuthResponse response = await _supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      setIsLoading = false;
    } catch (e) {
      setIsLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    }
  }

  Future signOut() async {
    await _supabaseClient.auth.signOut();
    notifyListeners();
  }

  User? get currentUser => _supabaseClient.auth.currentUser;
}
