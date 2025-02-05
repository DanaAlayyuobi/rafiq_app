import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/all_screens.dart';
import 'package:rafiq_app/screens/password_reset_screen.dart';
import 'package:rafiq_app/screens/register_screen.dart';
import 'package:rafiq_app/services/auth_services/auth_service.dart';
import 'package:rafiq_app/widget/button_widget.dart';
import 'package:rafiq_app/widget/text_feild_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isVisible = false;



    void _onTapLogin(BuildContext context) async {
      final authService = AuthService();
      try {
        await authService.signInWithEmailPassword("online",
            _emailController.text, _passwordController.text);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllScreens()));
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
              child: Text(
              e.toString(),
                style: TextStyle(
                    color: Colors.brown,fontSize: 16),
              ),
            ),
          ),
        );
      }
    }


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
                hitText: 'Password',
                isObscure: !_isVisible,
                TextController: _passwordController,
                iconButton: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member ? ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const Text(
                        "Register Now",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PasswordResetScreen()),
                    );
                  },
                  child: const Text(
                    "Forget Password ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
