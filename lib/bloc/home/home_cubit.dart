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

  int anxiousTaps = 0;
  int calmTaps = 0;

  void changePage(int page) {
    emit(HomeState.changePage(
      page: page,
      dialogCard: state.dialogCard,
      barAlteration: state.anxietyBarWidth,
      anxiousTaps: anxiousTaps,
      calmTaps: calmTaps,
    ));
  }

  void onChooseMood(DialogCard dialogCard) async {
    if (dialogCard == DialogCard.finishedMeasure) {
      try {
        await _connector.mutation(GraphQlMutations.addHistory, variables: {
          'user_id': userId,
          'anxiousTaps': anxiousTaps,
          'calmTaps': calmTaps,
        });
      } on Exception catch (error) {
        print(error);
      }
    }
    emit(
      HomeState.chooseMood(
        page: state.page,
        dialogCard: dialogCard,
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
