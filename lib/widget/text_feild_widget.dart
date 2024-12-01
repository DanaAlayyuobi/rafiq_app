import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  final String hitText;
  final bool isObscure;
  final TextEditingController TextController;
  final Icon? icon;
  final FocusNode? focusNode;
  final IconButton ?iconButton;

  const TextFeildWidget({
    required this.isObscure,
    required this.hitText,
    required this.TextController,
    this.focusNode,
    this.icon,
     this.iconButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      child: Container(
        height: 60,
        child: TextFormField(
          style: TextStyle(color: Theme
              .of(context)
              .colorScheme
              .onSurface),
          obscureText: isObscure,
          controller: TextController,
          focusNode: focusNode,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme
                      .of(context)
                      .colorScheme
                      .primary)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme
                      .of(context)
                      .colorScheme
                      .primary)
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: hitText,
              hintStyle: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .onSurface,),
              suffix:iconButton,
          ),
        ),
      ),
    );
  }
}
