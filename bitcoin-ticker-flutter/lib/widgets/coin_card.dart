import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard(
      {Key key,
      @required this.conversionRate,
      @required this.selectedCurrency,
      @required this.coinType})
      : super(key: key);

  final num conversionRate;
  final String selectedCurrency;
  final String coinType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coinType = ${conversionRate ?? "?"} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
