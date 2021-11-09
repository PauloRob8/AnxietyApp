import 'package:anxiety_app/bloc/diary/diary_cubit.dart';
import 'package:anxiety_app/bloc/home/home_cubit.dart';
import 'package:anxiety_app/bloc/home/home_state.dart';
import 'package:anxiety_app/bloc/login/login_cubit.dart';
import 'package:anxiety_app/pages/diary/diary_page.dart';
import 'package:anxiety_app/widgets/teddy/teddy_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  static PageRoute<dynamic> route({
    required String? userId,
  }) =>
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
            ),
            BlocProvider<DiaryCubit>(
              create: (context) => DiaryCubit(
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
            ),
            buildBottomNavigationBarItem(
              icon: FontAwesomeIcons.trophy,
              label: "Conquistas",
              size: 30,
            ),
          ],
          currentIndex: state.page,
          onTap: cubit.changePage,
        ),
        body: _getPage(state),
      );

  Widget _getPage(HomeState state) {
    switch (state.page) {
      case 1:
        return Center(
          child: Stack(
            children: [
              GestureDetector(
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
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: _dialogCard(),
              ),
            ],
          ),
        );

      case 2:
        return DiaryPage();

      default:
        return SizedBox();
    }
  }

  Widget _dialogCard() => SlideTransition(
        position: Tween<Offset>(
          begin: Offset(-1, 0),
          end: Offset.zero,
        ).animate(_animationController),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                width: 2.0,
                color: Colors.white,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.blueGrey,
                ],
              ),
            ),
            child: Center(
              child: Text(
                'Olá, como vai você ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
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
