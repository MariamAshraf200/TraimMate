import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widget/widget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const List<Color> _colors = [
    Color(0xff1c4257),
    Color(0xff253340),
  ];
  static const String _loginTitle = 'LOGIN';
  static const String _loginSubtitle = 'Enter To Your account';

  final ButtonWidget buttonWidget = ButtonWidget();

  LoginPage({super.key});  // Assuming it's defined

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/location');
          } else if (state is AuthFailure) {
            // Show error message on failure
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Stack(
          children: [
            _buildBackground(), // Background with gradient
            _buildLoginForm(context),  // Main login form with email, password, and buttons
          ],
        ),
      ),
    );
  }

  // Gradient background
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

  // Login form layout
  Widget _buildLoginForm(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),  // Title (LOGIN)
            _buildSubtitle(),  // Subtitle (Enter To Your account)
            buttonWidget.textFieldButton(
              _emailController,
              'Email',
              Icons.email,
            ),  // Email input
            buttonWidget.textFieldButton(
              _passwordController,
              'Password',
              Icons.password,
            ),  // Password input
            _buildLoginButton(context),  // Login button
            _buildForgotPasswordRow(context),  // Forget Password section
            _buildSignUpPrompt(context),  // Sign-up button
          ],
        ),
      ),
    );
  }

  // Login title
  Widget _buildTitle() {
    return Text(
      _loginTitle,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Login subtitle
  Widget _buildSubtitle() {
    return const Text(
      _loginSubtitle,
      style: TextStyle(color: Colors.grey),
    );
  }

  // Login button
  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: buttonWidget.textButtonWithcontainer('Login', () {
          final email = _emailController.text;
          final password = _passwordController.text;
          context.read<AuthBloc>().add(
            LoginEvent(
              email: email,
              password: password,
            ),
          );
        }),
      ),
    );
  }

  // Forgot password and reset section
  Widget _buildForgotPasswordRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Forget Your Password?',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        buttonWidget.textButton('Reset Password', () {
          // Add reset password logic here
        }),
      ],
    );
  }

  // Sign-up prompt
  Widget _buildSignUpPrompt(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');  // Navigates to signup page
      },
      child: const Text(
        "Don't have an account? Sign Up",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}
