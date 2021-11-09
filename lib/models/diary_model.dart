class DiaryModel {
  String id;
  DateTime date;
  String title;
  String description;

  DiaryModel({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
  });

  factory DiaryModel.fromHasura(value) {
    return DiaryModel(
      id: value['id'],
      date: DateTime.parse(value['date']),
      description: value['description'],
      title: value['title'],
    );
  }

  static List<DiaryModel> listFromHasura(List<dynamic> list) =>
      list.map((data) => DiaryModel.fromHasura(data)).toList();
}
