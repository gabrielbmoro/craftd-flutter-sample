import 'dart:convert';

import 'package:craftd_widget/data/model/base/simple_properties.dart';
import 'package:flutter/cupertino.dart';

class LocalDataSource {

  Future<List<SimpleProperties>> loadProperties(BuildContext context) async {
    var value = await DefaultAssetBundle.of(context)
        .loadString("assets/uiElements.json");

    List<dynamic> list = jsonDecode(value);
    return list.map((properties) {
      return SimpleProperties.fromJson(properties);
    }).toList();
  }
}
