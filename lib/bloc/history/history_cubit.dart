import 'dart:developer';

import 'package:anxiety_app/bloc/history/history_state.dart';
import 'package:anxiety_app/models/history_model.dart';
import 'package:anxiety_app/network/graphql/graphql_queries.dart';
import 'package:anxiety_app/network/hasura_connector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    required this.userId,
  }) : super(HistoryState.loading());

  final String userId;
  final HasuraConnector _connector = HasuraConnector();

  Future<void> getUserHistory() async {
    emit(HistoryState.loading());
    try {
      final data =
          await _connector.query(GraphQlQueries.getUserHistories, variables: {
        'user_id': userId,
      });

      final histories = HistoryModel.listFromHasura(data['data']['histories']);

      histories.sort((a, b) => b.date.compareTo(a.date));

      emit(HistoryState.fetched(histories: histories));
    } on Exception catch (error) {
      log(error.toString());
    }
  }
}
