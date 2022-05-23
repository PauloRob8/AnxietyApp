import 'package:anxiety_app/models/history_model.dart';

class HistoryState {
  HistoryState({
    required this.isLoading,
    required this.histories,
    required this.hasError,
  });

  factory HistoryState.loading() => HistoryState(
        isLoading: true,
        histories: [],
        hasError: false,
      );

  factory HistoryState.fetched({
    required List<HistoryModel> histories,
  }) =>
      HistoryState(
        isLoading: false,
        histories: histories,
        hasError: false,
      );

  factory HistoryState.error() => HistoryState(
        isLoading: false,
        histories: [],
        hasError: true,
      );

  final bool isLoading;
  final List<HistoryModel> histories;
  final bool hasError;
}
