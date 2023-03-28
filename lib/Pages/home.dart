// ignore_for_file: prefer_const_constructors

import 'package:diseaseapp/Pages/prediction.dart';
import 'package:diseaseapp/Pages/uploadImage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> prevReports = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return UploadReport();
              });
        },
        child: const Icon(Icons.add),
      ),
      body: prevReports.isEmpty
          ? noPrevReports()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("There are reports"),
              ],
            ),
    );
  }

  Center noPrevReports() {
    return Center(
      child: Text(
        "No Previous Reports Yet",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 22,
        ),
      ),
    );
  }
}
