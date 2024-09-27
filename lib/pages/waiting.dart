import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class Waiting extends StatefulWidget {
  const Waiting({super.key});

  @override
  State<Waiting> createState() => _WaitingState();
}


class _WaitingState extends State<Waiting> {
  @override
  void initState() {
    super.initState();

    checkInternetConnection();
  }

  // Separate async function to handle internet check
  Future<void> checkInternetConnection() async {
    bool connection = await InternetConnection().hasInternetAccess;
    if (connection) {
      // Delay and navigate to another route
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, "/home");
      });
    } else {
    return showDialog<void>(context: context, builder: (BuildContext ctx){
      return AlertDialog(

        title: Text("Confirm Internet Access"),

    content: Text("Dear customer ensure you have internet access before using this app"),

      );
    }


    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade600,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
Image(image: AssetImage('assets/images/SAF-MAIN-LOGO.jpg')),
              Text(
                "Safaricom is for you",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2.0,  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
