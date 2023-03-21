import 'package:flutter/material.dart';

class PredictionPage extends StatefulWidget {
  final String para1;
  final String para2;
  final String para3;
  final String para4;
  final String para5;
  const PredictionPage(
      {super.key,
      required this.para1,
      required this.para2,
      required this.para3,
      required this.para4,
      required this.para5});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction'),
      ),
      body: isLoading ? loadingScreen() : screen(),
    );
  }

  Widget loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget screen() {
    return Column(
      children: [
        Text(widget.para1),
        Text(widget.para2),
        Text(widget.para3),
        Text(widget.para4),
        Text(widget.para5),
      ],
    );
  }
}
