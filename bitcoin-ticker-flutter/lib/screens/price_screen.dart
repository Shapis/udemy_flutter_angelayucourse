import 'package:bitcoin_ticker/services/coin.dart';
import 'package:flutter/material.dart';
import '../utilities/coin_data.dart' as coinData;
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/widgets/coin_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<CoinCard> coinCardList = [];

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currencyName in coinData.currenciesList) {
      dropdownItems.add(
        DropdownMenuItem<String>(
          child: Text(currencyName),
          value: currencyName,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            updateCoinCards();
          },
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currencyName in coinData.currenciesList) {
      pickerItems.add(Text(currencyName));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = coinData.currenciesList[selectedIndex];
        updateCoinCards();
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();
    generateCoinCards();
    updateCoinCards();
  }

  void generateCoinCards() {
    for (var item in coinData.cryptoList) {
      coinCardList.add(CoinCard(
          conversionRate: null,
          selectedCurrency: selectedCurrency,
          coinType: item));
    }
  }

  void updateCoinCards() async {
    List<CoinCard> myCoinCardList = [];
    List<Future<dynamic>> futureCoinModelDataList = [];
    List<num> currencyRateList = [];

    for (var item in coinData.cryptoList) {
      futureCoinModelDataList
          .add(CoinModel().getCoinData(item, selectedCurrency));
    }

    for (var item in futureCoinModelDataList) {
      var temp = await item;
      num tempNum = temp['rate'];
      double tempDouble = tempNum.toDouble();
      currencyRateList.add(double.parse(tempDouble.toStringAsFixed(2)));
    }

    for (var i = 0; i < coinData.cryptoList.length; i++) {
      myCoinCardList.add(CoinCard(
        coinType: coinData.cryptoList[i],
        conversionRate: currencyRateList[i],
        selectedCurrency: selectedCurrency,
      ));
    }

    updateUI(myCoinCardList);
  }

  void updateUI(List<CoinCard> myCoinCardList) {
    setState(() {
      coinCardList = myCoinCardList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: coinCardList,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
