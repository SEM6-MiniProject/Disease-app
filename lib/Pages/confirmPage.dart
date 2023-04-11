import 'dart:io';

import 'package:diseaseapp/Pages/prediction.dart';
import 'package:diseaseapp/colors.dart';
import 'package:flutter/material.dart';

class ConfirmImagePage extends StatelessWidget {
  final File imageFile;
  const ConfirmImagePage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Image"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PredictionPage(
                        imageFile: imageFile,
                      )));
        },
        child: const Icon(Icons.check),
      ),
      body: Column(
        children: [
          Expanded(child: Image.file(imageFile)),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Do u want to preceed further with the above report ?",
              style: TextStyle(fontSize: 18, color: MyColors.secondaryColor),
            ),
          )
        ],
      ),
    );
  }
}
