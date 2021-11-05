import 'package:anxiety_app/widgets/teddy/teddy_controller.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  static PageRoute<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _teddyController = TeddyController();
  late AnimationController _animationController;
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
        child: Scaffold(
          backgroundColor: Colors.lightBlue,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.blue[50],
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
            currentIndex: 0,
            onTap: null,
          ),
          body: Center(
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
          ),
        ),
      ),
    );
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
