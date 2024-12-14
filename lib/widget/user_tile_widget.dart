import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final String name;
  final String status;

  final void Function()? onTap;

  const UserTileWidget({super.key, required this.name, this.onTap,required this.status});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color:Color(0x32FFCB00),
            borderRadius: BorderRadius.circular(4)
        ),
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.person,color: Theme.of(context).colorScheme.onSurface,),
            SizedBox(width: 8.0),
            Text(name,style: TextStyle(color:Theme.of(context).colorScheme.onSurface ),),

          ],),
      ),
    );
  }
}
