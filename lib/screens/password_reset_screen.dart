import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_app/widget/button_widget.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  // Function to send password reset email (without checking if the email is registered)
  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final email = _emailController.text.trim();

    try {
      // Send the password reset email regardless of email registration status
      await _auth.sendPasswordResetEmail(email: email);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent!')),
      );
      Navigator.pop(context); // Go back to the previous screen
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      // Show Firebase-specific error messages
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The email address is badly formatted.')),
        );
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found with that email...')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('retry again please, ${e.message}')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });

      // General error handling for non-Firebase issues
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Retry Again, $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30// Set the color of the back button to white
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please, enter your email to reset your password.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'abc@gmail.com',
                  hintStyle: TextStyle(color: Color(0x42836164))),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? Center(
                    child:
                        const CircularProgressIndicator()) // Show loading indicator while the email is being sent
                : ButtonWidget(
                    buttonLabel: "Send Reset Link",
                    onTap: () {
                      _resetPassword();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
