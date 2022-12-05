import 'package:cloud_firestore/cloud_firestore.dart';

class QuizHistoryModel {
  String? type;
  String? day;
  String? time;
  String? totalQuestions;
  String? correctAns;
  String? uid;
  String? img;
  String? level;


  QuizHistoryModel(
      {
        this.img,
        this.level,
        this.type,
        this.time,
        this.correctAns,
        this.day,
        this.totalQuestions,
        this.uid
      });

  factory QuizHistoryModel.fromMap(Map<String, dynamic> map) {
    return QuizHistoryModel(
      type: map['type'] as String,
      day: map['day'] as String,
      totalQuestions: map['totalQuestions'] as String,
      correctAns: map['Correct Answers'] as String,
      time: map['time'] as String,
      uid: map['uid'] as String,
      img: map['img'] as String,
      level: map['level'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'time': time,
      'day': day,
      'totalQuestions': totalQuestions,
      'Correct Answers': correctAns,
      'uid': uid,
      'level': level,
      'img': img,
    };
  }
}