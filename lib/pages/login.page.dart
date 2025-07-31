import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxWidth: 400,
            maxHeight: 520,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 32,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "images/enset.png",
                    height: 120,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "Welcome Back",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Sign in to continue",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 32),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(16),
                  child: TextFormField(
                    controller: loginController,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline, color: theme.colorScheme.primary),
                      labelText: "Username",
                      hintText: "Enter your username",
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(16),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline, color: theme.colorScheme.primary),
                      labelText: "Password",
                      hintText: "Enter your password",
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      suffixIcon: Icon(Icons.visibility_outlined, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      String username = loginController.text;
                      String password = passwordController.text;
                      if (username == 'admin' && password == 'admin') {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      textStyle: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, letterSpacing: 1.2),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
