import 'package:flutter/material.dart';
import 'package:flora_emosens/screens/api_service.dart'; // Make sure the path matches your structure

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  String? _message;

  void _register() async {
    try {
      final response = await _apiService.registerUser(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        _message = response['message'];
      });

      // If registration is successful, navigate to the Login screen
      if (response['status'] == 'success') {
        // Navigate to the login screen
        Navigator.pushReplacementNamed(context, '/');
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
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
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
              onPressed: _register,
              child: Text('Register'),
            ),
            if (_message != null) ...[
              SizedBox(height: 20),
              Text(_message!),
            ],
          ],
        ),
      ),
    );
  }
}
