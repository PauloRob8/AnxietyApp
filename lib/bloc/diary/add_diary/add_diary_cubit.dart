import 'package:anxiety_app/bloc/diary/add_diary/add_diary_state.dart';
import 'package:anxiety_app/network/graphql/graphql_mutations.dart';
import 'package:anxiety_app/network/hasura_connector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDiaryCubit extends Cubit<AddDiaryState> {
  AddDiaryCubit({
    required this.userId,
    HasuraConnector? connector,
  })  : _connector = connector ?? HasuraConnector(),
        super(AddDiaryState.initial());

  final HasuraConnector _connector;
  String? userId;

  void onValidateFields({
    required String title,
    required String diary,
  }) {
    if (title.isEmpty) {
      emit(
        AddDiaryState.error(errorType: AddDiaryError.emptyTitle),
      );
    } else if (diary.isEmpty) {
      emit(
        AddDiaryState.error(errorType: AddDiaryError.emptyDiary),
      );
    } else {
      _onAddDiary(title: title, diary: diary);
    }
  }

  Future<void> _onAddDiary({
    required String title,
    required String diary,
  }) async {
    emit(AddDiaryState.loading());
    try {
      await _connector.mutation(GraphQlMutations.addDiary, variables: {
        'user_id': userId,
        'title': title,
        'description': diary,
      });

      emit(AddDiaryState.added());
    } on Exception catch (error) {
      print(error);
    }
  }
}
