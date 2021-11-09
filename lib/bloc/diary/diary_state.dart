import 'package:anxiety_app/models/diary_model.dart';

enum DiaryError {
  none,
  internet,
  generic,
}

class DiaryState {
  DiaryState({
    required this.isLoading,
    required this.diaries,
    required this.errorType,
  });

  factory DiaryState.loading() => DiaryState(
        isLoading: true,
        diaries: [],
        errorType: DiaryError.none,
      );

  factory DiaryState.fetched({
    required List<DiaryModel> diaries,
  }) =>
      DiaryState(
        isLoading: false,
        diaries: diaries,
        errorType: DiaryError.none,
      );

  factory DiaryState.error({
    required DiaryError errorType,
  }) =>
      DiaryState(
        isLoading: false,
        diaries: [],
        errorType: errorType,
      );

  final bool isLoading;
  final List<DiaryModel> diaries;
  final DiaryError errorType;
}
