import 'package:anxiety_app/bloc/diary/diary_cubit.dart';
import 'package:anxiety_app/bloc/history/history_cubit.dart';
import 'package:anxiety_app/bloc/home/home_cubit.dart';
import 'package:anxiety_app/bloc/home/home_state.dart';
import 'package:anxiety_app/bloc/login/login_cubit.dart';
import 'package:anxiety_app/pages/achievements/achievements_page.dart';
import 'package:anxiety_app/pages/diary/diary_page.dart';
import 'package:anxiety_app/pages/history/historys_page.dart';
import 'package:anxiety_app/widgets/dialog_cards/anxious_card_widget.dart';
import 'package:anxiety_app/widgets/dialog_cards/calm_card_widget.dart';
import 'package:anxiety_app/widgets/dialog_cards/finished_card_widget.dart';
import 'package:anxiety_app/widgets/teddy/teddy_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  static PageRoute<dynamic> route({
    required String userId,
  }) =>
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(
                userId: userId,
              ),
            ),
            BlocProvider<DiaryCubit>(
              create: (context) => DiaryCubit(
                userId: userId,
              ),
            ),
            BlocProvider(
              create: (context) => HistoryCubit(
                userId: userId,
              ),
            ),
          ],
          child: HomePage(),
        ),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _teddyController = TeddyController();
  late AnimationController _animationController;

  LoginCubit get authCubit => context.read<LoginCubit>();
  HomeCubit get cubit => context.read<HomeCubit>();

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => _makeBody(state),
        ),
      ),
    );
  }

  Scaffold _makeBody(HomeState state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
        backgroundColor: Colors.lightBlue,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.lightBlueAccent[100],
          items: <BottomNavigationBarItem>[
            buildBottomNavigationBarItem(
              icon: Icons.history,
              size: 30,
              label: "Histórico",
              color: Colors.brown,
            ),
            buildBottomNavigationBarItem(
              icon: Icons.home,
              size: 30,
              label: "Início",
            ),
            buildBottomNavigationBarItem(
              icon: Icons.book,
              size: 30,
              label: "Diário",
              color: Colors.green,
            ),
            buildBottomNavigationBarItem(
              icon: FontAwesomeIcons.trophy,
              label: "Conquistas",
              size: 30,
              color: Colors.yellow,
            ),
          ],
          currentIndex: state.page,
          onTap: cubit.changePage,
        ),
        body: _getPage(state),
      );

  Widget _getPage(HomeState state) {
    switch (state.page) {
      case 0:
        return HistorysPage();
      case 1:
        return Column(
          children: [
            state.dialogCard == DialogCard.anxiousCard
                ? _anxietyBar(state)
                : SizedBox(),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 90.0),
                    child: GestureDetector(
                      onTap: () => _teddyController.play('success'),
                      child: FlareActor(
                        'assets/Teddy.flr',
                        controller: _teddyController,
                        shouldClip: false,
                        callback: (name) {
                          if (name != "fail") {
                            _teddyController.play("success");
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: _dialogCard(state),
                  ),
                ],
              ),
            ),
          ],
        );

      case 2:
        return DiaryPage();

      case 3:
        return AchievementsPage();

      default:
        return SizedBox();
    }
  }

  Widget _anxietyBar(HomeState state) => Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
        ),
        child: Column(
          children: [
            AnimatedContainer(
              height: 60.0,
              width: state.anxietyBarWidth,
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 2, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () => cubit.onChooseMood(
                  DialogCard.finishedMeasure,
                ),
                child: Text('FINALIZAR'),
              ),
            ),
          ],
        ),
      );

  Widget _dialogCard(HomeState state) => AnimatedCrossFade(
        firstChild: _getDialogCard(state),
        secondChild: _getDialogCard(state),
        crossFadeState: CrossFadeState.showFirst,
        duration: Duration(
          milliseconds: 300,
        ),
      );

  Widget _getDialogCard(HomeState state) {
    switch (state.dialogCard) {
      case DialogCard.calmCard:
        return CalmCardWidget(
          cubit: cubit,
        );

      case DialogCard.anxiousCard:
        return AnxiousCardWidget(cubit: cubit);

      case DialogCard.finishedMeasure:
        return FinishedCardWidget(
          cubit: cubit,
        );
      default:
        return _makeFirstDialog();
    }
  }

  Widget _makeFirstDialog() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 220.0,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 2.0,
              color: Colors.blueGrey,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50.0,
                  horizontal: 30.0,
                ),
                child: Text(
                  'Olá eu sou o Teddy ! Como você está se sentindo agora ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Overlock',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _teddyController.play('success');
                      cubit.onChooseMood(DialogCard.calmCard);
                    },
                    child: Text('CALMO'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _teddyController.play('fail');
                      cubit.onChooseMood(DialogCard.anxiousCard);
                    },
                    child: Text('ANSIOSO'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required double size,
    Color color = Colors.white,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      label: label,
      activeIcon: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
