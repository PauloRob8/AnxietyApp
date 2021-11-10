import 'package:anxiety_app/bloc/diary/diary_cubit.dart';
import 'package:anxiety_app/bloc/diary/diary_state.dart';
import 'package:anxiety_app/pages/diary/add_diary_page.dart';
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
    }

    return _makeBody(state);
  }

  Widget _makeBody(DiaryState state) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Meu diário',
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
            state.diaries.isEmpty
                ? _makeBodyWithoutData()
                : Expanded(
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
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    await Navigator.of(context).push(
                      AddDiaryPage.route(
                        userId: _cubit.userId,
                      ),
                    );

                    _cubit.onGetDiaries();
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget _makeBodyWithoutData() {
    return Expanded(
      child: Column(
        children: [
          Icon(
            Icons.book,
            size: 200.0,
            color: Colors.white,
          ),
          Text(
            'Bem-vindo(a) a sessão de diário! \n\nAqui é seu espaço pessoal '
            'para escrever qualquer coisa que desejar, seja em um momento bom ou ruim, '
            'se conhecer é um passo importantíssimo para o bem dá saúde mental. '
            '\n\nClique no botão + para adicionar seu primeiro diário',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
