import 'package:anxiety_app/models/achievement_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage() : super();

  @override
  State<AchievementsPage> createState() => _AchievementsState();
}

class _AchievementsState extends State<AchievementsPage> {
  final list = [
    AchievementModel(
      title: 'O Inicio da jornada',
      description: 'Logue no App pela primeira vez.',
      unlocked: true,
      date: '',
      imagePath: 'assets/images/adventureIcon.png',
    ),
    AchievementModel(
      title: 'Tranquilidade',
      description: 'Marque como Calmo na tela inicial 10 vezes.',
      unlocked: true,
      date: '',
      imagePath: 'assets/images/relief_icon.jpeg',
    ),
    AchievementModel(
      title: 'Engajado',
      description: 'Use o App 7 dias seguidos.',
      unlocked: false,
      date: '',
      imagePath: 'assets/images/rewardIcon.png',
    ),
    AchievementModel(
      title: 'Escritor',
      description: 'Faça 10 anotações no diário.',
      unlocked: false,
      date: '',
      imagePath: 'assets/images/notepad_icon.png',
    ),
  ];

  @override
  void initState() {
    super.initState();

    //
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _makeHeader(),
            Expanded(
              child: _makeAchievementsList(),
            ),
          ],
        ),
      );

  Widget _makeHeader() => Container(
        color: Colors.lightBlueAccent,
        child: Column(
          children: [
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
            const SizedBox(height: 20.0),
            Text(
              'LVL 1  0/100 XP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'PressStart2P',
                color: Colors.white,
              ),
            ),
            Divider(
              indent: 25.0,
              endIndent: 25.0,
              color: Colors.black,
            ),
          ],
        ),
      );

  Widget _makeAchievementsList() => ListView.builder(
        itemBuilder: (context, index) => _makeAchievementCard(
          list[index],
        ),
        itemCount: list.length,
      );

  Widget _makeAchievementCard(
    AchievementModel achievementModel,
  ) =>
      Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 15.0,
              bottom: 15.0,
              top: 15.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    height: 120.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                        left: 100.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            achievementModel.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              fontFamily: 'Overlock',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              achievementModel.description,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Overlock',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12.0,
                                right: 15.0,
                              ),
                              child: Icon(
                                achievementModel.unlocked
                                    ? FontAwesomeIcons.lockOpen
                                    : FontAwesomeIcons.lock,
                                color: achievementModel.unlocked
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _achievementImage(achievementModel),
        ],
      );

  Widget _achievementImage(
    AchievementModel achievement,
  ) =>
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: SizedBox(
          height: 100.0,
          width: 100.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  achievement.imagePath,
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    //

    super.dispose();
  }
}
