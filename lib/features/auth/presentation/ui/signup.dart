import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widget/widget.dart';  // Assuming this is where ButtonWidget is defined

class SignUpPage extends StatelessWidget {
  // Controllers for the text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // Constants for design
  static const List<Color> _colors = [
    Color(0xff1c4257),
    Color(0xff253340),
  ];
  static const String _signUpTitle = 'SIGN UP';
  static const String _signUpSubtitle = 'Create your account';

  final ButtonWidget buttonWidget = ButtonWidget();  // Assuming it's defined

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Stack(
          children: [
            _buildBackground(),  // Background gradient
            _buildSignUpForm(context),  // Main form layout
          ],
        ),
      ),
    );
  }

  // Background gradient
  Widget _buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _colors,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }

  // Sign-up form layout
  Widget _buildSignUpForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),  // Title (SIGN UP)
            _buildSubtitle(),  // Subtitle (Create your account)

            buttonWidget.textFieldButton(
              _nameController,
              'Name',
              Icons.person,
            ),
            buttonWidget.textFieldButton(
              _emailController,
              'Email',
              Icons.email,
            ),  // Email input

            buttonWidget.textFieldButton(
            _phoneController,
              'Phone',
              Icons.phone,
            ),  // Email in
            buttonWidget.textFieldButton(
              _passwordController,
              'Password',
              Icons.password,
            ),
            _buildSignUpButton(context),  // Sign-up button
            _buildLoginPrompt(context),  // Already have an account prompt
          ],
        ),
      ),
    );
  }

  // Sign-up title
  Widget _buildTitle() {
    return const Text(
      _signUpTitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Sign-up subtitle
  Widget _buildSubtitle() {
    return const Text(
      _signUpSubtitle,
      style: TextStyle(color: Colors.grey),
    );
  }

  // Sign-up button
  Widget _buildSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: buttonWidget.textButtonWithcontainer('Sign Up', () {
          final email = _emailController.text;
          final password = _passwordController.text;
          final phone =_phoneController.text;
          final name = _nameController.text;
          context.read<AuthBloc>().add(
            SignUpEvent(email: email, password: password, name:name,phone: phone ),
          );
        }),
      ),
    );
  }

  // Already have an account? Login prompt
  Widget _buildLoginPrompt(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);  // Navigate back to login page
      },
      child: const Text(
        'Already have an account? Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
