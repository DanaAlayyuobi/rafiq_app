import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/screens/Login_screen.dart';
import 'package:rafiq_app/screens/all_screens.dart';
import 'package:rafiq_app/widget/button_widget.dart';
import 'package:rafiq_app/widget/text_feild_widget.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isVisible = false;
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _onTapRegister(BuildContext context) async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AllScreens()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
    //home screen go
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
                height: 6,
              ),
              TextFeildWidget(
                hitText: 'Confirm password',
                isObscure: !_isVisible,
                TextController: _confirmPasswordController,
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
                buttonLabel: "Register",
                onTap: () {
                  _onTapRegister(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account , ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,fontSize: 16),
                      ),
                      const Text(
                        "Login Now",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
