import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage() : super();

  @override
  State<AchievementsPage> createState() => _AchievementsState();
}

class _AchievementsState extends State<AchievementsPage> {
  @override
  void initState() {
    super.initState();

    //
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _trophyIcon(),
            Text(
              'LVL 1  0/100 XP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'PressStart2P',
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'CONQUISTAS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                fontFamily: 'PressStart2P',
              ),
            ),
            Divider(
              indent: 25.0,
              endIndent: 25.0,
              color: Colors.black,
            ),
            Expanded(
              child: _makeAchievementsList(),
            ),
          ],
        ),
      );

  Widget _trophyIcon() => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: SizedBox(
          height: 120.0,
          width: 120.0,
          child: CircleAvatar(
            backgroundColor: Colors.green[200],
            child: Icon(
              FontAwesomeIcons.gamepad,
              color: Colors.yellowAccent,
              size: 60.0,
            ),
          ),
        ),
      );

  Widget _makeAchievementsList() => ListView.builder(
        itemBuilder: (context, index) => _makeAchievementCard(),
        itemCount: 5,
      );

  Widget _makeAchievementCard() => Row(
        children: [
          SizedBox(
            height: 80.0,
            width: 70.0,
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(255, 174, 174, 178),
              child: Icon(
                FontAwesomeIcons.trophy,
              ),
            ),
          )
        ],
      );

  @override
  void dispose() {
    //

    super.dispose();
  }
}
