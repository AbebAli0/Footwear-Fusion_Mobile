import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:shoes_store/presentation/auth/widget/auth_field_widget.dart';
import 'package:shoes_store/presentation/auth/widget/header_auth_field.dart';
import 'package:shoes_store/presentation/auth/widget/padding_auth_field.dart';
import 'package:shoes_store/providers/auth_provider.dart';

import '../../../core/theme/theme.dart';
import '../../routes/app_pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullNameController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Sign Up',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Register and Happy Shopping!',
                    style: subtitleTextStyle,
                  ),
                  const SizedBox(height: 30),
                  const PaddingAuth(child: HeaderAuthField(title: 'Full Name')),
                  AuthField(
                      prefixIcon: Image.asset('assets/auth/full_name_auth.png'),
                      controller: fullNameController,
                      hint: 'Your Full Name'),
                  const PaddingAuth(child: HeaderAuthField(title: 'Username')),
                  AuthField(
                      prefixIcon: Image.asset('assets/auth/username_auth.png'),
                      controller: usernameController,
                      hint: 'Your Username'),
                  const PaddingAuth(
                      child: HeaderAuthField(title: 'Email Address')),
                  AuthField(
                    prefixIcon: Image.asset(
                      'assets/icon_email.png',
                      width: 18,
                    ),
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
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 90),
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50)),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // Call the handleSignUp function
                            await handleSignUp(context);
                          }
                        },
                        child: Text(
                          'Sign Up',
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
                      Text('Already have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: secondaryTextColor.withOpacity(.5))),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushReplacement(context, Routes.login()),
                        child: Text('Sign In',
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

  // Function to handle sign-up
  Future<void> handleSignUp(BuildContext context) async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context,
        listen: false); // Get the AuthProvider instance
    bool signUpSuccess = await authProvider.register(
      name: fullNameController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    if (signUpSuccess) {
      Navigator.pushReplacement(context,
          Routes.main()); // Navigate to main page on successful sign-up
    }
  }
}
