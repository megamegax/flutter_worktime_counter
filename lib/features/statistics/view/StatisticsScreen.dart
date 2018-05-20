import 'package:flutter/material.dart';
import 'package:worktime_flutter/features/statistics/view/QuoteCard.dart';
import 'package:worktime_flutter/features/statistics/view/QuoteLoadingCard.dart';
import 'package:worktime_flutter/features/statistics/view/StatsCard.dart';
import 'package:worktime_flutter/redux/model/Quote.dart';
import 'package:worktime_flutter/redux/model/models.dart';

class StatisticsScreen extends StatelessWidget {
  String dailyWorkTime;
  String monthlyWorkTime;
  String averageWorkTime;
  Quote quote;
  bool isLoading;

  StatisticsScreen(
      {this.dailyWorkTime,
      this.monthlyWorkTime,
      this.averageWorkTime,
      this.quote,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Column(children: [
        new Hero(
          tag: 'main_card',
          child: new Card(
            elevation: 2.0,
            color: Colors.white,
            child: new Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                  left: 50.0,
                ),
                child: new StatsCard(
                    dailyWorkTime: dailyWorkTime,
                    monthlyWorkTime: monthlyWorkTime,
                    averageWorkTime: averageWorkTime)),
          ),
        ),
        new Center(
            child: isLoading
                ? new QuoteLoadingCard()
                : new QuoteCard(quote: quote))
      ]),
    );
  }
}
