import 'package:anxiety_app/bloc/diary/diary_cubit.dart';
import 'package:anxiety_app/bloc/diary/diary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiaryPage extends StatefulWidget {
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  DiaryCubit get _cubit => context.read<DiaryCubit>();

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();

    _cubit.onGetDiaries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiaryCubit, DiaryState>(
      bloc: _cubit,
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, DiaryState state) {}

  Widget _builder(BuildContext context, DiaryState state) {
    if (state.isLoading) {
      return Center(
        child: SpinKitThreeBounce(
          color: Colors.white,
        ),
      );
    } else if (state.diaries.isNotEmpty) {
      return _makeBodyWithData(state);
    } else {
      return Center(
        child: Text(
            'Aqui é seu espaço, sinta-se a vontade para falar como está se sentindo.'),
      );
    }
  }

  Widget _makeBodyWithData(DiaryState state) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Meu diário',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Colors.black,
              endIndent: MediaQuery.of(context).size.width * 0.3,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.diaries.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.redAccent,
                        ),
                      ),
                      onTap: () {},
                      leading: Icon(Icons.book),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            state.diaries[index].title,
                          ),
                          Text(
                            DateFormat.yMd('pt_BR').add_Hm().format(
                                  state.diaries[index].date,
                                ),
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(height: 8)
                        ],
                      ),
                      subtitle: Text(
                        state.diaries[index].description,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
