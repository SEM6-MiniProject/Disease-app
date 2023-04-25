import 'dart:convert';
import 'dart:io';

import 'package:diseaseapp/Model/prediction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class InputPredictionPage extends StatefulWidget {
  final PredictionModel inputs;

  const InputPredictionPage({
    super.key,
    required this.inputs,
  });

  @override
  State<InputPredictionPage> createState() => _InputPredictionPageState();
}

class _InputPredictionPageState extends State<InputPredictionPage> {
  Future<PredictionModel> getPrediction() async {
    print("Getting Prediction");
    final url = Uri.parse("https://animea-prediction.onrender.com/predict");
    final response = await http.post(
      url,
      body: json.encode(widget.inputs.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final res = json.decode(await response.body);
      print("Success");
      print(res);
      return PredictionModel.fromJson(res);
    } else {
      print(response.statusCode);
      print("Failed");
    }
    return PredictionModel(
      prediction: 1,
      data: {
        "MCV": "100",
      },
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
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Text(
            "Has Anemia: ${pred.prediction == 1 ? "Yes" : "No"}",
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          for (var key in pred.data.keys)
          if (key == 'gender')
            Text("Gender : ${pred.data[key] == 1 ? "Male" : "Female"}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          else
            Text(
              "$key: ${pred.data[key]}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }

  Widget errorScreen() {
    return const Center(
      child: Text("Error"),
    );
  }
}
