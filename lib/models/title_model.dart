
class TitleModel {

  String? title;
  String? homeUrl;
  String? generalUrl;
  String? id;

  TitleModel(
      {
        this.id,
        this.generalUrl,
        this.homeUrl,
        this.title,
      });

  factory TitleModel.fromMap(Map<String, dynamic> map) {
    return TitleModel(

      title: map['title'] ?? "",
      id: map['id'] ?? "",
      homeUrl: map['homeUrl']  ?? "https://firebasestorage.googleapis.com/v0/b/insurance-hero-app.appspot.com/o/english.png?alt=media&token=258ea94a-c6b6-40d2-876b-58be1a5c76e8",
      generalUrl: map['historyUrl'] ?? "",
    );
  }

}