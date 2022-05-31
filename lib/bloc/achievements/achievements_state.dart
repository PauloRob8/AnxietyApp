import 'package:anxiety_app/models/user_model.dart';

class AchievementsState {
  AchievementsState({
    required this.isLoading,
    required this.user,
    required this.lvledUp,
  });

  factory AchievementsState.initial() => AchievementsState(
        isLoading: false,
        user: null,
        lvledUp: false,
      );

  factory AchievementsState.loading() => AchievementsState(
        isLoading: true,
        user: null,
        lvledUp: false,
      );

  factory AchievementsState.fetched({
    required UserModel user,
  }) =>
      AchievementsState(
        isLoading: false,
        user: user,
        lvledUp: false,
      );

  factory AchievementsState.lvledUp({
    required UserModel user,
  }) =>
      AchievementsState(
        isLoading: false,
        user: user,
        lvledUp: true,
      );

  final bool isLoading;
  final UserModel? user;
  final bool lvledUp;
}
