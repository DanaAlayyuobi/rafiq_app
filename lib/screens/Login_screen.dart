import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/register_screen.dart';
import 'package:rafiq_app/widget/button_widget.dart';
import 'package:rafiq_app/widget/text_feild_widget.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _onTapLogin(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/rafiqlogo.png'),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFeildWidget(
                hitText: 'Email',
                isObscure: false,
                TextController: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFeildWidget(
                hitText: 'password',
                isObscure: true,
                TextController: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                buttonLabel: "Login",
                onTap: () {
                  _onTapLogin(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    "not a member? Register Now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
