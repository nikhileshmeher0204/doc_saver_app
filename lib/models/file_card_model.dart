class FileCardModel {
  final String title;
  final String subTitle;
  final String dateAdded;
  final String fileType;
  final String fileUrl;
  final String fileName;

  FileCardModel({
    required this.title,
    required this.subTitle,
    required this.dateAdded,
    required this.fileType,
    required this.fileUrl,
    required this.fileName,
  });

  factory FileCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FileCardModel(
      title: json["title"].toString(),
      subTitle: json["note"].toString(),
      dateAdded: json["dateAdded"].toString(),
      fileType: json["fileType"].toString(),
      fileUrl: json["fileUrl"].toString(),
      fileName: json["fileName"].toString(),
    );
  }
}
