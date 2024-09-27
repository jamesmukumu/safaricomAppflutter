import 'package:flutter/material.dart';

class Lipanampesa extends StatelessWidget {
  const Lipanampesa({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(text: "Till Number",),
            Tab(text: "Paybill",),
            Tab(text: "Pochi la Biashara",)

          ],
          indicatorColor: Colors.green.shade600,
          ),
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, "/home");
          }, icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.green.shade600,
          title: Text("Lipa na Mpesa",style:
            TextStyle(color: Colors.white,fontSize: 20.0,letterSpacing: 2.0),),
        ),

        body: TabBarView(children: [
          LipaMpesa(),
          Paybill(),
          pochiBiashara()
        ]),
      ),
    );
  }
}






class LipaMpesa extends StatefulWidget {
  const LipaMpesa({super.key});

  @override
  State<LipaMpesa> createState() => _LipaMpesaState();
}

class _LipaMpesaState extends State<LipaMpesa> {
  final TextEditingController tillNumber = TextEditingController();
  final TextEditingController amount = TextEditingController();
  String? errMsg;
bool showButton = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void fieldsValidator(){
    final till = tillNumber.text;
    final Amount = amount.text;
setState(() {
  if (till.isEmpty || Amount.isEmpty){
    errMsg = "Kindly fill all inputs before you continue";
  }else{
    errMsg = null;
  }
  
  showButton = !till.isEmpty && !Amount.isEmpty;
  
});
  }

  @override
  void initState() {
    super.initState();
   amount.addListener(fieldsValidator);
   tillNumber.addListener(fieldsValidator);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    amount.dispose();
    tillNumber.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(

      children: [
        TextField(
          maxLength: 6,
          keyboardType: TextInputType.number,
          controller: tillNumber,
          decoration: InputDecoration(
            hintText: "Enter till number"
          ),
        ),
        SizedBox(height: 30.0,),
        TextField(
          controller: amount,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter Amount",
            errorText: errMsg
          ),
        ),
        SizedBox(height: 29.0,),
        FilledButton(onPressed: showButton ? (){}: null, child: Text("Pay",style: TextStyle(
          color: Colors.white
        ),),
        style: ButtonStyle(
          backgroundColor: showButton ? MaterialStateProperty.all(Colors.green.shade600):MaterialStateProperty.all(Colors.grey.shade600)
        ),
        )
      ],
    ));
  }
}











class Paybill extends StatefulWidget {
  const Paybill({super.key});

  @override
  State<Paybill> createState() => _PaybillState();
}



class _PaybillState extends State<Paybill> {
  final TextEditingController paybillNumber = TextEditingController();
final TextEditingController accountNumber = TextEditingController();
final TextEditingController Amount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String? errText;
bool showButton = false;
void validateApprove(){
  final paybill = paybillNumber.text;
  final account = accountNumber.text;
final amount = Amount.text;
  setState(() {
    if(!paybill.isEmpty && !account.isEmpty && !amount.isEmpty){
      showButton = true;
    }else{
      showButton = false;
    }
    if(paybill.length < 6){
      showButton = false;
      errText =  "Paybill number cannot be less than 6";
    }else{
      errText = null;
    }
  });

}


@override
  void initState() {
paybillNumber.addListener(validateApprove);
accountNumber.addListener(validateApprove);
Amount.addListener(validateApprove);
    super.initState();
  }


  @override
  void dispose() {
  paybillNumber.dispose();
  accountNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form( key: _formKey,child: Column(
      children: [
        TextField(
          maxLength: 6,
          keyboardType: TextInputType.number,
          controller: paybillNumber,
          decoration: InputDecoration(
            hintText: "Enter Paybill Number",
            errorText: errText
          ),
        ),
        
        SizedBox(height: 20.0,),
        TextField(
          controller: accountNumber,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter Account number",

          ),
        ),
        SizedBox(height: 20.0,),
        TextField(
          controller: Amount,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter Amount"
          ),
        ),
        FilledButton(onPressed: showButton ? (){}:null, child: Text("Pay"),style: ButtonStyle(
          backgroundColor: showButton ? MaterialStateProperty.all(Colors.green.shade600):MaterialStateProperty.all(Colors.grey.shade600)
        ),)
      ],
    ));
  }
}









class pochiBiashara extends StatefulWidget {
  const pochiBiashara({super.key});

  @override
  State<pochiBiashara> createState() => _pochiBiasharaState();
}

class _pochiBiasharaState extends State<pochiBiashara> {
  @override
  Widget build(BuildContext context) {
    return Form(child: Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Phone Number"
          ),
        ),
        SizedBox(height: 60.0,),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: "Amount"
          ),
        ),
        SizedBox(height: 55.0,),
        FilledButton(onPressed: (){}, child: Text("Pay"),style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green.shade600)
        ),)


      ],
    ));
  }
}
