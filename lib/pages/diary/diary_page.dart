import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';

class DiaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Meu diário',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.055,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.black,
            endIndent: MediaQuery.of(context).size.width * 0.3,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
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
                          'É O TESTAS',
                        ),
                        Text(
                          'uuq',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                    subtitle: Text(
                      'sas',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
