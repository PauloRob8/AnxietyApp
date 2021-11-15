enum DialogCard {
  initialCard,
  calmCard,
  anxiousCard,
}

class HomeState {
  HomeState({
    this.page = 1,
    this.dialogCard = DialogCard.initialCard,
  });

  factory HomeState.initial() => HomeState(
        page: 1,
        dialogCard: DialogCard.initialCard,
      );

  factory HomeState.changePage({
    required int page,
  }) =>
      HomeState(
        page: page,
      );

  factory HomeState.measureMood({
    required int page,
    required DialogCard dialogCard,
  }) =>
      HomeState(
        page: page,
        dialogCard: dialogCard,
      );

  final int page;
  final DialogCard dialogCard;
}
