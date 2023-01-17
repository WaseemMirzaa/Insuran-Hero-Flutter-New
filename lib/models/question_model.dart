
class QuestionModel {
  String? A;
  String? B;
  String? C;
  String? D;
  String? correctAns;
  String? question;
  String? hint;
  String? selectedAns;

  QuestionModel(
      {
        this.selectedAns,
        this.hint,
        this.question,
      this.correctAns,
      this.A,
      this.B,
      this.C,
      this.D});

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      A: map['A'] ?? "",
      B: map['B'] ?? "",
      C: map['C'] ?? "",
      D: map['D'] ?? "",
      correctAns: map['correctAns']  ?? "",
      question: map['question'] ?? "",
      hint: map['hint'],
      selectedAns: map['selectedAns'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'A': A,
      'B': B,
      'C': C,
      'D': D,
      'hint': hint,
      'correctAns': correctAns,
      'question': question,
      'selectedAns': selectedAns,
    };
  }
}