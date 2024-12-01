import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height:140 ,
        width:double.infinity,
        decoration: BoxDecoration(
            color: Theme
            .of(context)
            .colorScheme
            .primary,
            borderRadius: BorderRadius.circular(15.0)
        ),
        child: PageView(
          children: const [
            Center(child: Text("Story 1")),
            Center(child: Text("Story 2")),
            Center(child: Text("Story 3")),
            Center(child: Text("Story 4")),
            Center(child: Text("Story 5")),
            Center(child: Text("Story 6")),
          ],
        ),
      ),
    );
  }
}
