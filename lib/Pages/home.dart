// ignore_for_file: prefer_const_constructors

import 'package:diseaseapp/Pages/prediction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _para1controller;
  late TextEditingController _para2controller;
  late TextEditingController _para3controller;
  late TextEditingController _para4controller;
  late TextEditingController _para5controller;

  @override
  void initState() {
    super.initState();
    _para1controller = TextEditingController();
    _para2controller = TextEditingController();
    _para3controller = TextEditingController();
    _para4controller = TextEditingController();
    _para5controller = TextEditingController();
  }

  @override
  void dispose() {
    _para1controller.dispose();
    _para2controller.dispose();
    _para3controller.dispose();
    _para4controller.dispose();
    _para5controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease App'),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PredictionPage(
                          para1: _para1controller.text,
                          para2: _para2controller.text,
                          para3: _para3controller.text,
                          para4: _para4controller.text,
                          para5: _para5controller.text,
                        )));
          },
          child: const Text('Submit', style: TextStyle(fontSize: 20)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            myTextField(_para1controller, 'Para 1'),
            myTextField(_para2controller, 'Para 2'),
            myTextField(_para3controller, 'Para 3'),
            myTextField(_para4controller, 'Para 4'),
            myTextField(_para5controller, 'Para 5'),
          ],
        ),
      ),
    );
  }

  Widget myTextField(TextEditingController controller, String hint,
      {bool done = false}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        textInputAction: done ? TextInputAction.done : TextInputAction.next,
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.green,
          )),
          filled: true,
          fillColor: Colors.white,
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.green),
        ),
      ),
    );
  }
}
