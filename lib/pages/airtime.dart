import 'package:flutter/material.dart';

class Airtime extends StatelessWidget {
  const Airtime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, "/home");
        }, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.green.shade600,
        title:Text("Top up Airtime",style:
          TextStyle(
            color: Colors.white,
            fontSize: 20.0
          ),),
        centerTitle: true,
      ),
      body: SafaricomAirtimeTopUp(),
    );
  }
}




class SafaricomAirtimeTopUp extends StatefulWidget {
  const SafaricomAirtimeTopUp({super.key});




  @override
  State<SafaricomAirtimeTopUp> createState() => _SafaricomAirtimeTopUpState();
}

class _SafaricomAirtimeTopUpState extends State<SafaricomAirtimeTopUp> {
   final TextEditingController airtime = TextEditingController();
  bool showBtn = false;

  void validator(){
    final airt = airtime.text;
setState(() {
  showBtn =  !airt.isEmpty;
});
  }


  @override
  void initState() {
    super.initState();
    airtime.addListener(validator);
  }

  @override
  void dispose() {
 airtime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(child: Column(
      children: [
        TextField(
     maxLength: 5,
          controller: airtime,
          keyboardType: TextInputType.number,
decoration: InputDecoration(
  hintText: "Enter Airtime Amount"
),

        ),
        SizedBox(height: 30.0,),
        FilledButton(onPressed: showBtn ? (){} : null,style:
            ButtonStyle(
              backgroundColor: showBtn ? MaterialStateProperty.all(Colors.green.shade600):MaterialStateProperty.all(Colors.grey.shade600)
            ), child:Text("Buy airtime",style:
          TextStyle(
            fontSize: 20.0
          ),))
      ],
    ));
  }
}
