import 'package:flutter/material.dart';

class QuoteLoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Container(
            width: double.infinity,
            height: 95.0,
            child: new Center(
              child: new SizedBox(
                height: 30.0,
                width: 30.0,
                child: new CircularProgressIndicator(),
              ),
            )));
  }
}
