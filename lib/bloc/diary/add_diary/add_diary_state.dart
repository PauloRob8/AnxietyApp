enum AddDiaryError {
  none,
  emptyTitle,
  emptyDiary,
}

class AddDiaryState {
  AddDiaryState({
    required this.isLoading,
    required this.added,
    required this.errorType,
  });

  factory AddDiaryState.initial() => AddDiaryState(
        isLoading: false,
        added: false,
        errorType: AddDiaryError.none,
      );

  factory AddDiaryState.loading() => AddDiaryState(
        isLoading: true,
        added: false,
        errorType: AddDiaryError.none,
      );

  factory AddDiaryState.added() => AddDiaryState(
        isLoading: false,
        added: true,
        errorType: AddDiaryError.none,
      );

  factory AddDiaryState.error({
    required AddDiaryError errorType,
  }) =>
      AddDiaryState(
        isLoading: false,
        added: false,
        errorType: errorType,
      );

  final bool isLoading;
  final bool added;
  final AddDiaryError errorType;
}
