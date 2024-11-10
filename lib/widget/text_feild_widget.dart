import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  final String hitText;
  final bool isObscure;
  final TextEditingController TextController;
  final FocusNode? focusNode;
  const TextFeildWidget({
    required this.isObscure,
    super.key,
    required this.hitText,
    required this.TextController,
    this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 3),
      child: TextField(
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface ),
        obscureText:isObscure ,
        controller:TextController ,
        focusNode:focusNode ,
        decoration: InputDecoration(
            enabledBorder:OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
            ),
            fillColor: Colors.white,
            filled:true,
            hintText: hitText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface)
        ),
      ),
    );
  }
}
