import 'dart:developer';

import 'package:anxiety_app/bloc/achievements/achievements_state.dart';
import 'package:anxiety_app/models/user_model.dart';
import 'package:anxiety_app/network/graphql/graphql_queries.dart';
import 'package:anxiety_app/network/hasura_connector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AchievementsCubit extends Cubit<AchievementsState> {
  AchievementsCubit({
    required this.userId,
  }) : super(AchievementsState.initial());

  final String userId;

  HasuraConnector _connector = HasuraConnector();
  int previousLvl = 1;
  int currentLvl = 1;
  int xpForLvlUp = 300;

  Future<void> getXp() async {
    emit(AchievementsState.loading());
    try {
      final data =
          await _connector.query(GraphQlQueries.getUserXp(userId: userId));

      final user = UserModel.fromHasura(data['data']['users_by_pk']);

      getLvl(user);

      emit(AchievementsState.fetched(user: user));
      if (previousLvl != currentLvl) {
        emit(AchievementsState.lvledUp(user: user));
      }
    } on Exception catch (error) {
      log(error.toString());
    }
  }

  void getLvl(UserModel user) {
    previousLvl = currentLvl;
    if (user.xp == 300) {
      currentLvl = 2;
      xpForLvlUp = 600;
    } else if (user.xp > 300 && user.xp <= 600) {
      currentLvl = 3;
      xpForLvlUp = 1200;
    } else if (user.xp > 600 && user.xp <= 1200) {
      currentLvl = 4;
      xpForLvlUp = 2400;
    } else if (user.xp > 1200 && user.xp <= 2400) {
      currentLvl = 5;
      xpForLvlUp = 4800;
    } else if (user.xp > 2400 && user.xp <= 4800) {
      currentLvl = 6;
      xpForLvlUp = 9600;
    } else if (user.xp > 4800 && user.xp <= 9600) {
      currentLvl = 7;
      xpForLvlUp = 19200;
    } else if (user.xp > 9600 && user.xp <= 19200) {
      currentLvl = 8;
      xpForLvlUp = 38400;
    } else if (user.xp > 19200 && user.xp <= 38400) {
      currentLvl = 9;
      xpForLvlUp = 76800;
    } else if (user.xp > 38400 && user.xp <= 76800) {
      currentLvl = 10;
      xpForLvlUp = 76800;
    }
  }
}
