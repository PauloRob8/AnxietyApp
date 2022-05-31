import 'package:anxiety_app/network/graphql/graphql_mutations.dart';
import 'package:anxiety_app/network/hasura_connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.userId,
  }) : super(HomeState.initial());

  final String userId;
  final HasuraConnector _connector = HasuraConnector();

  int anxiousTaps = 0;
  int calmTaps = 0;

  List<Color?> colors = [
    Colors.blue[100],
    Colors.blue[200],
    Colors.blue[300],
    Colors.blue[400],
    Colors.blue[500],
    Colors.blue[600],
    Colors.red[100],
    Colors.red[200],
    Colors.red[400],
    Colors.red,
    Colors.red[600],
  ];

  void changePage(int page) {
    emit(HomeState.changePage(
      page: page,
      dialogCard: state.dialogCard,
      barAlteration: state.anxietyBarWidth,
      anxiousTaps: state.anxiousTaps,
      calmTaps: state.calmTaps,
    ));
  }

  void onChooseMood(DialogCard dialogCard) async {
    if (dialogCard == DialogCard.finishedMeasure) {
      emit(
        HomeState.loading(
          page: state.page,
          dialogCard: dialogCard,
          anxiousTaps: state.anxiousTaps,
          barAlteration: state.anxietyBarWidth,
          calmTaps: state.calmTaps,
        ),
      );
      try {
        await _connector.mutation(GraphQlMutations.addHistory, variables: {
          'user_id': userId,
          'anxiousTaps': state.anxiousTaps,
          'calmTaps': state.calmTaps,
        });

        await _connector.mutation(GraphQlMutations.increaseXp, variables: {
          'user_id': userId,
        });
      } on Exception catch (error) {
        print(error);
      }
      anxiousTaps = 0;
      calmTaps = 0;
    }
    emit(
      HomeState.chooseMood(
        page: state.page,
        dialogCard: dialogCard,
        finished: dialogCard == DialogCard.finishedMeasure,
      ),
    );
  }

  void onMeasureMood({
    required double value,
    required double screenMaxWidth,
  }) {
    final newWidth;

    if (value > 0) {
      anxiousTaps++;
    } else {
      calmTaps++;
    }

    if (value + state.anxietyBarWidth < 10) {
      newWidth = 10.0;
    } else if (value + state.anxietyBarWidth >= screenMaxWidth) {
      newWidth = screenMaxWidth;
    } else {
      newWidth = value += state.anxietyBarWidth;
    }
    emit(
      HomeState.measureMood(
        page: state.page,
        dialogCard: state.dialogCard,
        barAlteration: newWidth,
        anxiousTaps: anxiousTaps,
        calmTaps: calmTaps,
      ),
    );
  }
}
