import 'package:check_weather/features/user/presentation/page/home.dart';
import 'package:check_weather/features/user/presentation/page/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/widget.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // Constants
  static const List<Color> _colors = [
    Color(0xff1c4257),
    Color(0xff253340),
  ];
  static const String _loginTitle = 'LOGIN';
  static const String _loginSubtitle = 'Enter To Your account';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ButtonWidget buttonWidget = ButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: _authListener,
        child: _buildBody(context),
      ),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is SucessLoginstate) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    } else if (state is FailureLoginstate) {
      _showErrorMessage(context, state.message);
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(),
        _buildLoginForm(context),
      ],
    );
  }

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

  Widget _buildLoginForm(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          _buildSubtitle(),
          buttonWidget.textFieldButton(
            _emailController,
            'Email',
            Icons.email,
          ),
          buttonWidget.textFieldButton(
            _passwordController,
            'Password',
            Icons.password,
          ),
          _buildLoginButton(context),
          _buildForgotPasswordRow(context),
          _buildSignUpPrompt(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      _loginTitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      _loginSubtitle,
      style: TextStyle(color: Colors.grey),
    );
  }

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
          context
              .read<AuthBloc>()
              .add(LoginEvent(email: email, password: password));
        }),
      ),
    );
  }

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
        buttonWidget.textButton('Reset Password', () {}),
      ],
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      },
      child: const Text(
        "Don't have an account? Sign Up",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
