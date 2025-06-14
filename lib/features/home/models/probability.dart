import 'dart:convert';

class Probability {
  final String input;
  final String predicted;
  final double negativePercentage;
  final double partialPercentage;
  final double positivePercentage;

  Probability({required this.input, required this.predicted, required this.negativePercentage, required this.partialPercentage, required this.positivePercentage});

  Probability copyWith({
    String? input,
    String? predicted,
    double? negativePercentage,
    double? partialPercentage,
    double? positivePercentage
  }) {
    return Probability(input: input ?? this.input, predicted: predicted ?? this.predicted, negativePercentage: negativePercentage ?? this.negativePercentage, partialPercentage: partialPercentage ?? this.partialPercentage, positivePercentage: positivePercentage ?? this.positivePercentage);
  }


  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'input': input,
      'predicted': predicted,
      'negativePercentage': negativePercentage,
      'partialPercentage': partialPercentage,
      'positivePercentage': positivePercentage,
    };
  }

  factory Probability.fromMap(Map<String, dynamic> map){
    return Probability(input: map['input'] ?? '', predicted: map['predicted'] ?? '', negativePercentage: map['negativePercentage'] ?? '', partialPercentage: map['partialPercentage'] ?? '', positivePercentage: map['positivePercentage'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Probability.fromJson(String source) =>
    Probability.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  String toString(){
    return 'Probability(input: $input, predicted: $predicted, negativePercentage: $negativePercentage, partialPercentage: $partialPercentage, positivePercentage: $positivePercentage)';
  }
}