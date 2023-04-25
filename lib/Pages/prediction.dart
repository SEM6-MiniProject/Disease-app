import 'dart:convert';
import 'dart:io';

import 'package:diseaseapp/Model/prediction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PredictionPage extends StatefulWidget {
  final File imageFile;

  const PredictionPage({
    super.key,
    required this.imageFile,
  });

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  Future<PredictionModel> getPrediction() async {
    print("Getting Prediction");
    final url =
        Uri.parse("https://animea-prediction.onrender.com/predict_file");
    final req = http.MultipartRequest(
      'POST',
      url,
    );
    final originalName = widget.imageFile.path.split('/').last;
    final file = http.MultipartFile.fromBytes(
      "file",
      await File.fromUri(Uri.parse(widget.imageFile.path)).readAsBytes(),
      filename: originalName,
      contentType: MediaType('image', 'jpeg'),
    );
    req.files.add(file);
    final response = await req.send();
    if (response.statusCode == 200) {
      final res = json.decode(await response.stream.bytesToString());
      print("Success");
      print(res);
      return PredictionModel.fromJson(res);
    } else {
      print("Failed");
    }
    return PredictionModel(
      hasAnemia: "50",
      hemoglobin: "30",
      MCH: "20",
      MCHC: "10",
      gender: "Male",
      MCV: "20",
    );
    // return await Future.delayed(const Duration(seconds: 5), () {
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction'),
      ),
      body: FutureBuilder<PredictionModel>(
        future: getPrediction(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return screen(snapshot.data!);
          } else if (snapshot.hasError) {
            return errorScreen();
          } else {
            return loadingScreen();
          }
        },
      ),
    );
  }

  Widget loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget screen(PredictionModel pred) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.file(widget.imageFile),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Has Anemia: ${pred.hasAnemia}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Hemoglobin: ${pred.hemoglobin}",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "MCH: ${pred.MCH}",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "MCHC: ${pred.MCHC}",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "MCV: ${pred.MCV}",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget errorScreen() {
    return const Center(
      child: Text("Error"),
    );
  }
}
