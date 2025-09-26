import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/auth.dart';

class AuthStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _emailKey = 'auth_email';
  static const String _isLoggedInKey = 'is_logged_in';

  Future<void> saveAuth(Auth auth) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, auth.token);
    await prefs.setString(_emailKey, auth.email);
    await prefs.setBool(_isLoggedInKey, true);
  }

  Future<Auth?> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    
    if (!isLoggedIn) return null;
    
    final token = prefs.getString(_tokenKey);
    final email = prefs.getString(_emailKey);
    
    if (token == null || email == null) return null;
    
    return Auth(token: token, email: email);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_emailKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }
}