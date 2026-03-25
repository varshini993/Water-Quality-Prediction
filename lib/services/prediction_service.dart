class PredictionService {

  static String predict(List<double> values) {

    if (values.isEmpty) return "Unsafe";

    double avg = values.reduce((a, b) => a + b) / values.length;

    if (avg >= 6.5 && avg <= 8.5) {
      return "Safe";
    } else {
      return "Unsafe";
    }
  }
}