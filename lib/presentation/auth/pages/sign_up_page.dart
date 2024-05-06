import 'package:flutter/material.dart';
import 'package:shoes_store/presentation/auth/widget/auth_field_widget.dart';
import 'package:shoes_store/presentation/auth/widget/header_auth_field.dart';
import 'package:shoes_store/presentation/auth/widget/padding_auth_field.dart';

import '../../../core/theme/theme.dart';
import '../../routes/app_pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
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
                  AuthField(controller: fullNameController, hint: 'Your Full Name'),
                  const PaddingAuth(child: HeaderAuthField(title: 'Username')),
                  AuthField(controller: usernameController, hint: 'Your Username'),
                  const PaddingAuth(child: HeaderAuthField(title: 'Email Address')),
                  AuthField(
                    controller: emailController,
                    hint: 'Your Email Address',
                    inputType: TextInputType.emailAddress,
                  ),
                  const PaddingAuth(child: HeaderAuthField(title: 'Password')),
                  AuthField(
                    controller: passwordController,
                    hint: 'Your Password',
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //TODO: Methodmu deleh kene
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                          )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account? ', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, Routes.login()),
                        child: Text('Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: primaryColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
