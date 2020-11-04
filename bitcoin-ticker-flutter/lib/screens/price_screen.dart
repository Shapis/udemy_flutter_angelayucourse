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
  Map<String, String> conversionValuesMap;
  bool isWaiting = false;

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
            updateData();
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
        //updateCoinCards();
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  List<CoinCard> generateCoinCards() {
    List<CoinCard> coinCardList = [];

    for (var i = 0; i < coinData.cryptoList.length; i++) {
      coinCardList.add(
        CoinCard(
          conversionRate:
              isWaiting ? null : conversionValuesMap[coinData.cryptoList[i]],
          selectedCurrency: selectedCurrency,
          coinType: coinData.cryptoList[i],
        ),
      );
    }

    return coinCardList;
  }

  void updateData() async {
    isWaiting = true;
    try {
      var data = await coinData.CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        conversionValuesMap = data;
      });
    } catch (err) {
      print(err);
    }
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
            children: generateCoinCards(),
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
