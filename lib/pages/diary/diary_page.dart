import 'package:anxiety_app/bloc/diary/diary_cubit.dart';
import 'package:anxiety_app/bloc/diary/diary_state.dart';
import 'package:anxiety_app/pages/diary/add_diary_page.dart';
import 'package:anxiety_app/pages/diary/diary_detail_page.dart';
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
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Container(
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
                  fontFamily: 'Overlock',
                ),
              ),
              Divider(
                color: Colors.black,
                endIndent: MediaQuery.of(context).size.width * 0.3,
              ),
              BlocBuilder<DiaryCubit, DiaryState>(
                bloc: _cubit,
                builder: _builder,
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
        ),
      );

  Widget _builder(BuildContext context, DiaryState state) {
    if (state.isLoading) {
      return Expanded(
        child: SpinKitSpinningLines(
          size: 100.0,
          color: Colors.white,
        ),
      );
    } else if (state.diaries.isEmpty) {
      return _makeBodyWithoutData();
    }
    return _makeDiariesList(state);
  }

  Widget _makeDiariesList(DiaryState state) => Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.diaries.length,
          itemBuilder: (_, index) {
            return _makeDiaryCard(state, index);
          },
        ),
      );

  Widget _makeDiaryCard(DiaryState state, int index) => GestureDetector(
        onTap: () => Navigator.of(context).push(
          DiaryDetailPage.route(
            diaryModel: state.diaries[index],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            elevation: 2.0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/notepad_icon.png',
                    width: 80.0,
                    height: 80.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        state.diaries[index].title,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
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
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );
  Widget _makeBodyWithoutData() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 40.0,
                top: 50.0,
                bottom: 40.0,
              ),
              child: Image.asset(
                'assets/images/notepad_icon.png',
                width: 140.0,
                height: 140.0,
              ),
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
      ),
    );
  }
}
