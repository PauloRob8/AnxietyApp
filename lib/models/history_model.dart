class HistoryModel {
  HistoryModel({
    required this.id,
    required this.date,
    required this.anxiousTaps,
    required this.calmTaps,
  });

  final String id;
  final DateTime date;
  final int anxiousTaps;
  final int calmTaps;

  factory HistoryModel.fromHasura(value) {
    return HistoryModel(
      id: value['id'] as String,
      date: DateTime.parse(value['date']),
      anxiousTaps: value['anxiousTaps'] as int,
      calmTaps: value['calmTaps'] as int,
    );
  }

  static List<HistoryModel> listFromHasura(List<dynamic> list) =>
      list.map((data) => HistoryModel.fromHasura(data)).toList();
}
