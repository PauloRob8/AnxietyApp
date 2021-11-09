class HomeState {
  HomeState({
    this.page = 1,
  });

  factory HomeState.initial() => HomeState(
        page: 1,
      );

  factory HomeState.changePage({
    required int page,
  }) =>
      HomeState(
        page: page,
      );

  final int page;
}
