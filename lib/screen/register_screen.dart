import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/widgets/button.global.dart';
import 'package:flutter_application_1/screen/widgets/social.login.dart';
import 'package:flutter_application_1/screen/widgets/text.form.global.dart';
import 'package:flutter_application_1/utils/global.color.dart';
import 'package:flutter_application_1/screen/login_screen.dart';
import 'package:flutter_application_1/services/auth_services.dart';
import 'dart:convert';
import 'package:flutter_application_1/utils/password_visibility_notifier.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController no_teleponController = TextEditingController();
  final TextEditingController posisiController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final PasswordVisibilityNotifier passwordVisibilityNotifier = PasswordVisibilityNotifier(true);
  final PasswordVisibilityNotifier confirmPasswordVisibilityNotifier = PasswordVisibilityNotifier(true);

  @override
  void dispose() {
    // Dispose controllers to free up resources
    nameController.dispose();
    emailController.dispose();
    no_teleponController.dispose();
    posisiController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

Future<void> register(BuildContext context) async {
  // Validasi input
  if (nameController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwordController.text.isEmpty ||
      confirmPasswordController.text.isEmpty ||
      no_teleponController.text.isEmpty ||
      posisiController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all fields')),
    );
    return;
  }

  if (no_teleponController.text.length < 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No Telepon must be at least 10 characters')),
    );
    return;
  }

  if (passwordController.text.length < 6) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password must be at least 6 characters')),
    );
    return;
  }

  if (passwordController.text != confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Passwords do not match')),
    );
    return;
  }

  // Logging input untuk debugging
  print('Name: ${nameController.text}');
  print('Email: ${emailController.text}');
  print('No Telepon: ${no_teleponController.text}');
  print('Posisi: ${posisiController.text}');
  print('Password: ${passwordController.text}');
  print('Confirm Password: ${confirmPasswordController.text}');

  try {
    final response = await AuthServices.register(
      nameController.text,
      emailController.text,
      no_teleponController.text,
      posisiController.text,
      passwordController.text,
    );

    print('Response Status: ${response.statusCode}');
    print('Response: ${response.body}');

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final String errorMessage =
          responseBody['message'] ?? 'Registration failed. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An unexpected error occurred: $e')),
    );
  }
}



@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/logo1.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 50),
              Text(
                'Create a new account',
                style: TextStyle(
                  color: GlobalColors.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              TextFormGlobal(
                controller: nameController,  // Kontroler untuk nama
                text: 'Name',
                textInputType: TextInputType.text,
                icon: Icons.person,
                obscure: false,
              ),
              const SizedBox(height: 10),
              TextFormGlobal(
                controller: emailController,  // Kontroler untuk email
                text: 'Email',
                textInputType: TextInputType.emailAddress,
                icon: Icons.email,
                obscure: false,
              ),
              const SizedBox(height: 10),
              TextFormGlobal(
                controller: no_teleponController,  // Kontroler untuk no telepon
                text: 'No Telepon',
                textInputType: TextInputType.phone,
                icon: Icons.phone,
                obscure: false,
              ),
              const SizedBox(height: 10),
              TextFormGlobal(
                controller: posisiController,  // Kontroler untuk posisi
                text: 'Posisi',
                textInputType: TextInputType.text,
                icon: Icons.work,
                obscure: false,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: passwordVisibilityNotifier,
                builder: (context, obscurePassword, child) {
                  return TextFormGlobal(
                    controller: passwordController,  // Kontroler untuk password
                    text: 'Password',
                    textInputType: TextInputType.text,
                    icon: Icons.lock,
                    obscure: obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        passwordVisibilityNotifier.toggle();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder<bool>(
                valueListenable: confirmPasswordVisibilityNotifier,
                builder: (context, obscureConfirmPassword, child) {
                  return TextFormGlobal(
                    controller: confirmPasswordController,  // Kontroler untuk konfirmasi password
                    text: 'Confirm Password',
                    textInputType: TextInputType.text,
                    icon: Icons.lock,
                    obscure: obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        confirmPasswordVisibilityNotifier.toggle();
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              ButtonGlobal(
                text: 'Sign Up',
                onTap: () {
                  register(context);
                },
              ),
              const SizedBox(height: 25),
              SocialLogin(),
            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: Container(
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have an account? "),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                color: GlobalColors.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}
