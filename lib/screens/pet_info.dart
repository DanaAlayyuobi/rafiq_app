import 'package:flutter/material.dart';
import 'package:rafiq_app/widget/button_widget.dart';

import '../widget/labeled_progress_bar.dart';

class PetInfo extends StatefulWidget {
  const PetInfo({super.key});

  @override
  State<PetInfo> createState() => _PetInfoState();
}

class _PetInfoState extends State<PetInfo> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isFav = !_isFav;
                      });
                    },
                    icon: Icon(_isFav ? Icons.favorite : Icons.favorite_border,size: 30,)),

              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.location_pin,color: Colors.deepOrange,size: 30,),
                Text(
                  "Country , City",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Flexible( // Ensures text wraps to the next line
                  child: Text(
                    "jskhdhkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(child: LabeledProgressBar(label: 'Friendliness', progress: .1,)),
                Expanded(child: LabeledProgressBar(label: 'Friendliness', progress: 1,)),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: LabeledProgressBar(label: 'Friendliness', progress: .6,)),
                Expanded(child: LabeledProgressBar(label: 'Friendliness', progress: .9,)),
              ],
            ),
          ),
          SizedBox(height: 80,),
          ButtonWidget(buttonLabel: 'Adopt Me!',onTap: (){},),
        ],
      ),
    );
  }
}
