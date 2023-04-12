import 'dart:ffi';

class PredictionModel {
  final int prediction;
  final Map<String, dynamic> data;

  PredictionModel({
    required this.prediction,
    required this.data,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      prediction: json['prediction'],
      data: json['data'],
    );
  }
}
