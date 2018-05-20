import 'package:flutter/material.dart';
import 'package:worktime_flutter/redux/model/Quote.dart';

class QuoteCard extends StatelessWidget {
  Quote quote;

  QuoteCard({this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              quote.quote ?? "",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          new Container(
            width: double.infinity,
            child: new Text(
              quote?.author ?? "",
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ));
  }
}
