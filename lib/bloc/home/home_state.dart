enum DialogCard {
  initialCard,
  calmCard,
  anxiousCard,
  finishedMeasure,
}

class HomeState {
  HomeState({
    required this.page,
    required this.dialogCard,
    required this.anxietyBarWidth,
    required this.anxiousTaps,
    required this.calmTaps,
  });

  factory HomeState.initial() => HomeState(
        page: 1,
        dialogCard: DialogCard.initialCard,
        anxietyBarWidth: 10.0,
        anxiousTaps: 0,
        calmTaps: 0,
      );

  factory HomeState.changePage({
    required int page,
    required DialogCard dialogCard,
    required double barAlteration,
    required int anxiousTaps,
    required int calmTaps,
  }) =>
      HomeState(
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: barAlteration,
        anxiousTaps: anxiousTaps,
        calmTaps: calmTaps,
      );

  factory HomeState.chooseMood({
    required int page,
    required DialogCard dialogCard,
  }) =>
      HomeState(
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: 10.0,
        anxiousTaps: 0,
        calmTaps: 0,
      );

  factory HomeState.measureMood({
    required int page,
    required DialogCard dialogCard,
    required double barAlteration,
    required int anxiousTaps,
    required int calmTaps,
  }) =>
      HomeState(
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: barAlteration,
        anxiousTaps: anxiousTaps,
        calmTaps: calmTaps,
      );

  final int page;
  final DialogCard dialogCard;
  final double anxietyBarWidth;
  final int anxiousTaps;
  final int calmTaps;
}
