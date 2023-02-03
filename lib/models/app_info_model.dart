
class AppInfoModel {

  String? title;
  String? description;
  bool? isEnabled;

  AppInfoModel(
      {
        this.isEnabled,
        this.title,
        this.description
      });

  factory AppInfoModel.fromMap(Map<String, dynamic> map) {
    return AppInfoModel(
      description: map['description']  ?? [],
      title: map['title'] ?? "",
      isEnabled: map['isEnabled']  ?? false,
    );
  }

}