import 'package:flutter/material.dart';
import 'package:flora_emosens/screens/api_service.dart'; // Adjust the path

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  String? _message;
  String? _token;

  void _login() async {
    try {
      final response = await _apiService.loginUser(
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        _message = response['message'];
        _token = response['token'];
      });

      // If login is successful, navigate to the splash screen
      if (response['status'] == 'success') {
        Navigator.pushReplacementNamed(context, '/splash');
      }
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (_message != null) ...[
              SizedBox(height: 20),
              Text(_message!),
            ],
            if (_token != null) ...[
              SizedBox(height: 20),
              Text('Token: $_token'),
            ],
          ],
        ),
      ),
    );
  }
}
