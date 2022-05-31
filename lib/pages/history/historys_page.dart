import 'package:anxiety_app/bloc/history/history_cubit.dart';
import 'package:anxiety_app/bloc/history/history_state.dart';
import 'package:anxiety_app/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HistorysPage extends StatefulWidget {
  const HistorysPage() : super();

  @override
  State<HistorysPage> createState() => _HistorysState();
}

class _HistorysState extends State<HistorysPage> {
  HistoryCubit get cubit => context.read<HistoryCubit>();

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    cubit.getUserHistory();
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Histórico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  endIndent: MediaQuery.of(context).size.width * 0.3,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                BlocBuilder<HistoryCubit, HistoryState>(
                  bloc: cubit,
                  builder: _builder,
                )
              ],
            ),
          ),
        ),
      );

  Widget _builder(BuildContext context, HistoryState state) {
    if (state.isLoading) {
      return Expanded(
        child: SpinKitSpinningLines(
          size: 100.0,
          color: Colors.white,
        ),
      );
    } else if (state.histories.isEmpty) {
      return _makeEmptyHistories();
    }
    return _makeHistoryList(state);
  }

  Widget _makeEmptyHistories() => Center(
        child: Text(
          'Aqui ficará seu historico de interações com o aplicativo.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      );

  Widget _makeHistoryList(HistoryState state) => Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.histories.length,
          itemBuilder: (context, index) => _makeHistoryCard(
            state.histories[index],
          ),
        ),
      );

  Widget _makeHistoryCard(
    HistoryModel history,
  ) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.heartbeat,
                  color: Colors.red,
                ),
                title: Text(
                  'Clicks -> Ansioso ${history.anxiousTaps}x '
                  'Calmo ${history.calmTaps}x',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    fontFamily: 'Overlock',
                  ),
                ),
                subtitle: Text(
                  DateFormat.yMd('pt_BR').add_Hm().format(
                        history.date,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
}
