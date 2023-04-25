class PredictionModel {
  final String hasAnemia;
  final String hemoglobin;
  final String gender;
  final String MCH;
  final String MCHC;
  final String MCV;

  PredictionModel({
    required this.hasAnemia,
    required this.hemoglobin,
    required this.gender,
    required this.MCH,
    required this.MCHC,
    required this.MCV,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      hasAnemia: json['hasAnemia'] ?? "0.5",
      gender: json['gender'] == 1 ? "Male" : "Female",
      hemoglobin: json['Hemoglobin'] ?? "0",
      MCH: json['MCH'] ?? "0",
      MCHC: json['MCHC'] ?? "0",
      MCV: json['MCV'] ?? "0",
    );
  }

  Map<String, String> toJson(){
    return {
      "Hemoglobin": hemoglobin,
      "MCH": MCH,
      "MCHC": MCHC,
      "MCV": MCV,
      "Gender":gender =="Male"? "1":"0"
    };
  }
}
