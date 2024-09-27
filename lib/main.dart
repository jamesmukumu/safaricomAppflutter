import 'package:flutter/material.dart';
import 'package:safcom/pages/wifiOptions.dart';
import './pages/home.dart';
import './pages/waiting.dart';
import './pages/sendmoney.dart';
import './pages/lipanampesa.dart';
import './pages/airtime.dart';
import './pages/wifiOptions.dart';

void main() {


  runApp(MaterialApp(
    initialRoute: "/",
  routes: {
  "/":(context)=>Waiting(),
    "/home":(context)=>Home(),
    "/home/internet":(context)=>WifiPlans(),
    "/send/money":(context)=>Sendmoney(),
    "/lipa/mpesa":(context)=>Lipanampesa(),
    "/buy/airtime":(context)=>Airtime()
  },
  ));
}
