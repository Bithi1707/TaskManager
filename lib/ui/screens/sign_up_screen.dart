
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/service/network_caller.dart';
import 'package:task_manager_project/data/urls.dart';
import 'package:task_manager_project/ui/widgets/screen_background.dart';
import '../widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text("Join With Us", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 24),

                /// Email
                TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                /// First name
                TextFormField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'First name'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                /// Last name
                TextFormField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(hintText: 'Last name'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                /// Mobile
                TextFormField(
                  controller: _phoneController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your mobile number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                /// Password
                TextFormField(
                  obscureText: true,
                  controller: _passController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if ((value?.length ?? 0) <= 6) {
                      return "Enter a valid password (more than 6 characters)";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                /// Sign Up Button or Loader
                Visibility(
                  visible: !_signUpInProgress,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: _onTabSignUpButton,
                    child: const Icon(Icons.arrow_circle_right),
                  ),
                ),

                const SizedBox(height: 32),

                /// Already have account?
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Have an account? ",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = _onTabSignInButton,
                        ),
                      ],
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

  void _onTabSignUpButton() {
    if (_formkey.currentState!.validate()) {
      _signUp();//calls API
    }
  }

  Future<void> _signUp() async {
    setState(() => _signUpInProgress = true);

    Map<String, String> requestBody = {
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _phoneController.text.trim(),
      "password": _passController.text,
    };

    final response = await NetworkCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );

    setState(() => _signUpInProgress = false);

    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'Registration successful. Please login.');
    } else {
      showSnackBarMessage(context, response.errorMessage ?? 'Sign up failed');
    }
  }

  void _onTabSignInButton() {
    Navigator.pop(context);
  }
  void _clearTextFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passController.clear();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
