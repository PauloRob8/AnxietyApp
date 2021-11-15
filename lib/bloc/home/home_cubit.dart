import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void changePage(int page) {
    emit(HomeState.changePage(page: page));
  }

  void onMeasureMood(DialogCard dialogCard) {
    emit(
      HomeState.measureMood(
        page: state.page,
        dialogCard: dialogCard,
      ),
    );
  }
}
