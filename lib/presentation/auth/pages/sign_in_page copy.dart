import 'package:flutter/material.dart';
import 'package:shoes_store/core/theme/theme.dart';

import '../../routes/app_pages.dart';
import '../widget/auth_field_widget.dart';
import '../widget/header_auth_field.dart';
import '../widget/padding_auth_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
                  'Login',
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sign In to Countinue',
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
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 280),
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
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushReplacement(context, Routes.main());
                            //TODO: Methodmu deleh kene
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        )),
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
                      onTap: () =>
                          Navigator.pushReplacement(context, Routes.register()),
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
    ));
  }
}
