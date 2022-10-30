import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../country_model.dart';
///
/// read json all address of country (_countrys / _citys / _districts)
///
class CountryProvider {
  static final _instance = CountryProvider._internal();
  final _countrys = <Country>[];
  final _citys = <City>[];
  final _districts = <District>[];

  factory CountryProvider() {
    return _instance;
  }

  CountryProvider._internal() {
    getLisCountry();
  }

  Future getLisCountry() async {
    var jsonArray = await _getResponse() as List;

    for (var element in jsonArray) {
      _countrys.add(Country.fromJson(element));
    }
  }

  Future _getResponse() async {
    var res = await rootBundle
        .loadString('assets/json/country.json');
    return jsonDecode(res);
  }
}
