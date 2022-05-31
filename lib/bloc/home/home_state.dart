enum DialogCard {
  initialCard,
  calmCard,
  anxiousCard,
  finishedMeasure,
}

class HomeState {
  HomeState({
    required this.isLoading,
    required this.page,
    required this.dialogCard,
    required this.anxietyBarWidth,
    required this.anxiousTaps,
    required this.calmTaps,
    required this.finished,
  });

  factory HomeState.initial() => HomeState(
        isLoading: false,
        page: 1,
        dialogCard: DialogCard.initialCard,
        anxietyBarWidth: 10.0,
        anxiousTaps: 0,
        calmTaps: 0,
        finished: false,
      );

  factory HomeState.changePage({
    required int page,
    required DialogCard dialogCard,
    required double barAlteration,
    required int anxiousTaps,
    required int calmTaps,
  }) =>
      HomeState(
        isLoading: false,
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: barAlteration,
        anxiousTaps: anxiousTaps,
        calmTaps: calmTaps,
        finished: false,
      );

  factory HomeState.loading({
    required int page,
    required DialogCard dialogCard,
    required double barAlteration,
    required int anxiousTaps,
    required int calmTaps,
  }) =>
      HomeState(
        isLoading: true,
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: barAlteration,
        anxiousTaps: anxiousTaps,
        calmTaps: calmTaps,
        finished: false,
      );

  factory HomeState.chooseMood({
    required int page,
    required DialogCard dialogCard,
    required bool finished,
  }) =>
      HomeState(
        isLoading: false,
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: 10.0,
        anxiousTaps: 0,
        calmTaps: 0,
        finished: finished,
      );

  factory HomeState.measureMood({
    required int page,
    required DialogCard dialogCard,
    required double barAlteration,
    required int anxiousTaps,
    required int calmTaps,
  }) =>
      HomeState(
        isLoading: false,
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: barAlteration,
        anxiousTaps: anxiousTaps,
        calmTaps: calmTaps,
        finished: false,
      );

  final bool isLoading;
  final int page;
  final DialogCard dialogCard;
  final double anxietyBarWidth;
  final int anxiousTaps;
  final int calmTaps;
  final bool finished;
}
