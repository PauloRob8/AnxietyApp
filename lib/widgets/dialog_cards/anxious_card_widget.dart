import 'package:anxiety_app/bloc/home/home_cubit.dart';
import 'package:flutter/material.dart';

class AnxiousCardWidget extends StatelessWidget {
  const AnxiousCardWidget({
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
                  vertical: 30.0,
                  horizontal: 15.0,
                ),
                child: Text(
                  'O importante agora é fazer você se sentir melhor ! '
                  'Foque sua atenção na barra encima de mim. '
                  '\n\nAumenta-a e depois a diminua-a quando estiver se sentindo mais calmo.',
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
                      onPressed: () => cubit.onMeasureMood(
                        value: -10.0,
                        screenMaxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Text('DIMINUIR'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => cubit.onMeasureMood(
                        value: 10.0,
                        screenMaxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Text('AUMENTAR'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
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
