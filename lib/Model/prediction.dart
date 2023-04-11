class PredictionModel {
  final String hasAnemia;
  final String para1;
  final String para2;
  final String para3;

  PredictionModel({
    required this.hasAnemia,
    required this.para1,
    required this.para2,
    required this.para3,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      hasAnemia: json['hasAnemia'],
      para1: json['para1'] ?? "0",
      para2: json['para2'] ?? "0",
      para3: json['para3'] ?? "0",
    );
  }
}
