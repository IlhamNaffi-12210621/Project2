import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BeritaPanelProvider with ChangeNotifier {
  List data = [];

  Future<List> muatdata() async {
    final Url = "http://api.mediastack.com/v1/news?access_key=28ffdf1d8384a01446ab39b9c96acff5";
    final Response = await http.get(Uri.parse(Url));
    if(Response.statusCode != 200){
      data = [];
    }else{
      final js = jsonDecode(Response.body);
      data = js['data'];
    }
    notifyListeners();
    return data;
  }
}
