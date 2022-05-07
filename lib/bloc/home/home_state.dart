enum DialogCard {
  initialCard,
  calmCard,
  anxiousCard,
  finishedMeasure,
}

class HomeState {
  HomeState({
    this.page = 1,
    this.dialogCard = DialogCard.initialCard,
    this.anxietyBarWidth = 10.0,
  });

  factory HomeState.initial() => HomeState(
        page: 1,
        dialogCard: DialogCard.initialCard,
        anxietyBarWidth: 10.0,
      );

  factory HomeState.changePage({
    required int page,
  }) =>
      HomeState(
        page: page,
      );

  factory HomeState.chooseMood({
    required int page,
    required DialogCard dialogCard,
  }) =>
      HomeState(
        page: page,
        dialogCard: dialogCard,
      );

  factory HomeState.measureMood({
    required int page,
    required DialogCard dialogCard,
    required double barAlteration,
  }) =>
      HomeState(
        page: page,
        dialogCard: dialogCard,
        anxietyBarWidth: barAlteration,
      );

  final int page;
  final DialogCard dialogCard;
  final double anxietyBarWidth;
}
