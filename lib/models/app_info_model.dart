
class AppInfoModel {

  String? title;
  String? htmlData;
  bool? isEnabled;

  AppInfoModel(
      {
        this.isEnabled,
        this.title,
        this.htmlData
      });

  factory AppInfoModel.fromMap(Map<String, dynamic> map) {
    return AppInfoModel(
      htmlData: map['htmlData']  ?? [],
      title: map['title'] ?? "",
      isEnabled: map['isEnabled']  ?? false,
    );
  }

}