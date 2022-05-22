import 'package:anxiety_app/bloc/home/home_cubit.dart';
import 'package:anxiety_app/bloc/home/home_state.dart';
import 'package:flutter/material.dart';

class FinishedCardWidget extends StatelessWidget {
  const FinishedCardWidget({
    required this.cubit,
  }) : super();

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
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
                  'Espero que você esteja se sentindo bem agora ! '
                  'Você pode acessar a aba de diários caso queira me contar '
                  'sobre o que lhe deixou ansioso.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Overlock',
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => cubit.changePage(2),
                      child: Text('ACESSAR DIÁRIO'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => cubit.onChooseMood(
                        DialogCard.initialCard,
                      ),
                      child: Text('VOLTAR'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
