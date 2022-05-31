import 'package:anxiety_app/models/diary_model.dart';
import 'package:flutter/material.dart';

class DiaryDetailPage extends StatelessWidget {
  const DiaryDetailPage({
    required this.diary,
  }) : super();

  final DiaryModel diary;

  static PageRoute<dynamic> route({
    required DiaryModel diaryModel,
  }) =>
      MaterialPageRoute(
        builder: (context) => DiaryDetailPage(
          diary: diaryModel,
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        child: Scaffold(
          backgroundColor: Colors.lightBlue,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: _makeBody(context),
        ),
      );

  Widget _makeBody(BuildContext context) => Column(
        children: [
          Center(
            child: Text(
              diary.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
                fontFamily: 'Overlock',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    width: 2.0,
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 15.0,
                    left: 15.0,
                    bottom: 10.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      diary.description,
                      style: TextStyle(
                        fontFamily: 'Overlock',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 18.0,
              left: 18.0,
              bottom: 20.0,
            ),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('VOLTAR'),
              ),
            ),
          ),
        ],
      );
}
