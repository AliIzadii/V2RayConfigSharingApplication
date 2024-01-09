import 'dart:convert' as convert;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admin_version/models/v2ray.dart';

class Network {
  static List<v2rays> v2ray = [];
  static Uri url = Uri.parse('https://retoolapi.dev/IDDhLM/v2ray');
  static Uri urlWithId(String id) {
    return Uri.parse('https://retoolapi.dev/IDDhLM/v2ray/$id');
  }

  static bool isConnected = false;

  //! Check Internet
  static Future<bool> checkInternet() async {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.wifi ||
          status == ConnectivityResult.mobile ||
          status == ConnectivityResult.vpn) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    });
    return isConnected;
  }

  //! Show Internet Error
  static void showError(BuildContext context) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      width: 150,
      text: 'You are not connected to the Internet!',
      title: 'Fail',
      confirmBtnText: 'OK',
      confirmBtnTextStyle: TextStyle(fontSize: 16, color: Colors.white),
      confirmBtnColor: Colors.redAccent,
    );
  }

  //! Get Data
  static Future<void> getData() async {
    v2ray.clear();
    http.get(Network.url).then((response) {
      if (response.statusCode == 200) {
        List jsonDecode = convert.jsonDecode(response.body);
        for (var json in jsonDecode) {
          v2ray.add(v2rays.fromJson(json));
        }
      }
    });
  }

  //! Post Data
  static void postData({
    required String v2ray,
  }) async {
    v2rays confing = v2rays(v2ray: v2ray);
    http.post(url, body: confing.toJson()).then((value) {});
  }

  //! Delete Data
  static void deleteData(String id) {
    http.delete(urlWithId(id)).then((value) {
      getData();
    });
  }
}
