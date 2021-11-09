import 'package:anxiety_app/bloc/diary/diary_state.dart';
import 'package:anxiety_app/models/diary_model.dart';
import 'package:anxiety_app/network/graphql/graphql_queries.dart';
import 'package:anxiety_app/network/hasura_connector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit({
    required this.userId,
    HasuraConnector? connector,
  })  : _connector = connector ?? HasuraConnector(),
        super(DiaryState.loading());

  final String? userId;
  final HasuraConnector _connector;

  Future<void> onGetDiaries() async {
    try {
      final data =
          await _connector.query(GraphQlQueries.getUserDiaries, variables: {
        'user_id': userId,
      });

      final diaries = DiaryModel.listFromHasura(data['data']['diary']);

      emit(DiaryState.fetched(diaries: diaries));
    } on Exception catch (error) {
      print(error);
    }
  }
}
