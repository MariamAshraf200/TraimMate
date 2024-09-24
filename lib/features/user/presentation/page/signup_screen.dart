import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/widget.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<Color> colors = [
    const Color(0xff1c4257),
    const Color(0xff253340),
  ];

  final ButtonWidget buttonWidget = ButtonWidget();
  final String _invalidEmailMessage = "Please enter a valid email.";
  final String _invalidPasswordMessage = "Password must be at least 6 characters.";
  final String _invalidPhoneMessage = "Please enter a valid phone number."; // Example error message

  @override
  void dispose() {
    // Dispose of the text controllers
    _emailController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SuccesSignupstate) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else if (state is FailureSignUpstate) {
            _showErrorMessage(context, state.message);
          }
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SIGNUP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buttonWidget.textFieldButton(
                      _nameController,
                      'Name',
                      CupertinoIcons.profile_circled,
                    ),
                    buttonWidget.textFieldButton(
                      _emailController,
                      'Email',
                      Icons.email,
                    ),
                    buttonWidget.textFieldButton(
                      _phoneController,
                      'Phone',
                      CupertinoIcons.phone,
                    ),
                    buttonWidget.textFieldButton(
                      _passwordController,
                      'Password',
                      Icons.password,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: buttonWidget.textButtonWithcontainer('Submit', () {
                          _handleSignup(context);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignup(BuildContext context) {
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final name = _nameController.text.trim();
    final password = _passwordController.text.trim();

    // Basic validations
    if (!_isValidEmail(email)) {
      _showErrorMessage(context, _invalidEmailMessage);
      return;
    }
    if (password.length < 6) {
      _showErrorMessage(context, _invalidPasswordMessage);
      return;
    }
    context.read<AuthBloc>().add(
      SignupEvent(
        email: email,
        phone: phone,
        name: name,
        password: password,
      ),
    );
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
