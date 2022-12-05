import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String? A;
  String? B;
  String? C;
  String? D;
  String? correctAns;
  String? question;

  QuestionModel(
      {
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
    );
  }

// factory QuestionModel.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options) {
//   final data = snapshot.data();
//   return QuestionModel(
//       A: data?['A'] ?? "",
//       B: data?['B'] ?? "",
//       C: data?['C'] ?? "",
//       D: data?['D'] ?? "",
//       correctAns: data?['correctAns'],
//       question: data?['question'],
//   );
// }
}