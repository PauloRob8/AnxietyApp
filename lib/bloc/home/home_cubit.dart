import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

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
    emit(HomeState.changePage(page: page));
  }

  void onChooseMood(DialogCard dialogCard) {
    emit(
      HomeState.chooseMood(
        page: state.page,
        dialogCard: dialogCard,
      ),
    );
  }

  void onMeasureMood(double value) {
    final newWidth;

    if (value + state.anxietyBarWidth < 10) {
      newWidth = 10.0;
    } else {
      newWidth = value += state.anxietyBarWidth;
    }
    emit(
      HomeState.measureMood(
        page: state.page,
        dialogCard: state.dialogCard,
        barAlteration: newWidth,
      ),
    );
  }

  void _updateColor() {}
}
