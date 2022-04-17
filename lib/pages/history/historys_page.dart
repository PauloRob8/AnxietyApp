import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistorysPage extends StatefulWidget {
  const HistorysPage() : super();

  @override
  State<HistorysPage> createState() => _HistorysState();
}

class _HistorysState extends State<HistorysPage> {
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
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Histórico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  endIndent: MediaQuery.of(context).size.width * 0.3,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                _makeHistoryList(),
              ],
            ),
          ),
        ),
      );

  Widget _makeHistoryList() => ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) => _makeHistoryCard(),
      );

  Widget _makeHistoryCard() => Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.heartbeat,
              color: Colors.red,
            ),
            title: Text(
              'Normal',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('13/04/2022'),
          ),
        ),
      );

  @override
  void dispose() {
    //

    super.dispose();
  }
}
