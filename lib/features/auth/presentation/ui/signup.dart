import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widget/widget.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  static const List<Color> _colors = [
    Color(0xff1c4257),
    Color(0xff253340),
  ];
  static const String _signUpTitle = 'SIGN UP';
  static const String _signUpSubtitle = 'Create your account';

  final ButtonWidget buttonWidget = ButtonWidget();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Stack(
          children: [
            _buildBackground(height, width),
            _buildSignUpForm(context, height, width),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _colors,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget _buildSignUpForm(BuildContext context, double height, double width) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(width),
              SizedBox(height: height * 0.02),
              _buildSubtitle(width),
              SizedBox(height: height * 0.05),
              buttonWidget.textFieldButton(
                _nameController,
                'Name',
                Icons.person,
              ),  // Name input
              SizedBox(height: height * 0.001),
              buttonWidget.textFieldButton(
                _emailController,
                'Email',
                Icons.email,
              ),  // Email input
              SizedBox(height: height * 0.001),
              buttonWidget.textFieldButton(
                _phoneController,
                'Phone',
                Icons.phone,
              ),  // Phone input
              SizedBox(height: height * 0.001),
              buttonWidget.textFieldButton(
                _passwordController,
                'Password',
                Icons.password,
              ),  // Password input
              SizedBox(height: height * 0.05),
              _buildSignUpButton(context, width),
              SizedBox(height: height * 0.02),
              _buildLoginPrompt(context),
            ],
          ),
        ),
      ),
    );
  }

  // Sign-up title with responsive font size
  Widget _buildTitle(double width) {
    return Text(
      _signUpTitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: width * 0.1,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Sign-up subtitle with responsive font size
  Widget _buildSubtitle(double width) {
    return Text(
      _signUpSubtitle,
      style: TextStyle(
        color: Colors.grey,
        fontSize: width * 0.045,
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: buttonWidget.textButtonWithcontainer('Sign Up', () {
          final email = _emailController.text;
          final password = _passwordController.text;
          final phone = _phoneController.text;
          final name = _nameController.text;
          context.read<AuthBloc>().add(
            SignUpEvent(email: email, password: password, name: name, phone: phone),
          );
        }),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Already have an account? Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
