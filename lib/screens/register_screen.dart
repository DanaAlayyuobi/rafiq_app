import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/widget/button_widget.dart';
import 'package:rafiq_app/widget/text_feild_widget.dart';


class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  RegisterScreen({super.key});

  void _onTapRegister(BuildContext context) {//home screen go
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
                isObscure: true,
                TextController: _passwordController,
              ),
              const SizedBox(
                height: 6,
              ),
              TextFeildWidget(
                hitText: 'Confirm password',
                isObscure: true,
                TextController: _confirmPasswordController,
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                buttonLabel: "Register",
                onTap: (){_onTapRegister(context);},
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed:(){Navigator.pop(context);
                  } ,
                  child: Text(
                    "Already have an account , login now",
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
