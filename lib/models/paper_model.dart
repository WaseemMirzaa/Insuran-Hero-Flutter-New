
class PaperModel {

  String? title;
  int? time;
  List<dynamic>? questions;
  String? lessonNo;
  String? paperId;
  List<dynamic>? attemptedUsers;

  PaperModel(
      {
        this.attemptedUsers,
        this.paperId,
        this.lessonNo,
        this.time,
        this.title,
        this.questions
      });

  factory PaperModel.fromMap(Map<String, dynamic> map) {
    return PaperModel(
      questions: map['questions']  ?? [],
      title: map['title'] ?? "",
      time: map['timer']  ?? "",
      lessonNo: map['lessonNo']  ?? "",
      paperId: map['paperId'] ?? "",
      attemptedUsers: map['attemptedUsers'] ?? [],
    );
  }

}