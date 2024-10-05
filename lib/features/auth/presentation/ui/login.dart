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

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/location');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(

              SnackBar(content: Text(state.message),backgroundColor: Colors.red,),
            );
          }
        },
        child: Stack(
          children: [
            _buildBackground(height, width),
            _buildLoginForm(context, height, width),
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

  Widget _buildLoginForm(BuildContext context, double height, double width) {
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
                _emailController,
                'Email',
                Icons.email,
              ),  // Email input
              SizedBox(height: height * 0.002),
              buttonWidget.textFieldButton(
                _passwordController,
                'Password',
                Icons.password,
              ),  // Password input
              SizedBox(height: height * 0.02),
              _buildLoginButton(context, width),
              SizedBox(height: height * 0.05),
              _buildForgotPasswordRow(context),
              _buildSignUpPrompt(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(double width) {
    return Text(
      _loginTitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: width * 0.1,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle(double width) {
    return Text(
      _loginSubtitle,
      style: TextStyle(color: Colors.grey, fontSize: width * 0.045),
    );
  }

  Widget _buildLoginButton(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: width * 0.5,
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

  Widget _buildForgotPasswordRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Forget Password?',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        buttonWidget.textButton('Reset Password', () {
        }),
      ],
    );
  }


  Widget _buildSignUpPrompt(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: const Text(
        "Don't have an account? Sign Up",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
