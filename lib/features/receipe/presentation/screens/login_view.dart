import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO:use widget component such textField
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform login validation (hardcoded values for this example)
                final email = emailController.text;
                final password = passwordController.text;
                if (email == 'test@example.com' && password == 'password') {
                  Navigator.of(context).pushReplacementNamed('/recipeList');
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
