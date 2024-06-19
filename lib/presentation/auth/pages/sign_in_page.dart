import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shoes_store/core/theme/theme.dart';
import 'package:shoes_store/presentation/auth/pages/constants.dart';
import '../../routes/app_pages.dart';
import '../widget/auth_field_widget.dart';
import '../widget/header_auth_field.dart';
import '../widget/padding_auth_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('${Constants.baseUrl}api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String token = responseData['token'];
      Map<String, dynamic> user = responseData['user'];

      // Simpan token dan informasi pengguna menggunakan SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('email', user['email']);
      await prefs.setString('username', user['username']);
      await prefs.setInt('userId', user['id']);
      print(user['id']);

      // _showSnackbar("Login successful!", Colors.green);
      Navigator.pushReplacement(context, Routes.main());
    } else {
      _showSnackbar(
          "Login failed. Please check your email and password.", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Sign In to Continue',
                    style: subtitleTextStyle,
                  ),
                  const SizedBox(height: 30),
                  const PaddingAuth(
                      child: HeaderAuthField(title: 'Email Address')),
                  AuthField(
                    prefixIcon: Image.asset('assets/icon_email.png', width: 18),
                    controller: emailController,
                    hint: 'Your Email Address',
                    inputType: TextInputType.emailAddress,
                  ),
                  const PaddingAuth(child: HeaderAuthField(title: 'Password')),
                  AuthField(
                    prefixIcon:
                        Image.asset('assets/icon_password.png', width: 18),
                    controller: passwordController,
                    hint: 'Your Password',
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _obscureText = !_obscureText),
                      icon: Image.asset(
                        _obscureText
                            ? 'assets/icon_eye_closed.png'
                            : 'assets/icon_eye_open.png',
                        width: 24,
                        height: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 50),
                        ),
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  _login();
                                }
                              },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account? ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: secondaryTextColor.withOpacity(.5))),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context, Routes.register()),
                        child: Text('Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
