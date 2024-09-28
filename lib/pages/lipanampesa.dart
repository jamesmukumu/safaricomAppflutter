import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

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
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController text = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errMsg;
  List<Contact> myContacts = [];
  bool choosePochi = false;
  bool payBtn = false;


  void validator() {
    final phone = phoneNumber.text;
    final Amount = amount.text;

    setState(() {
      if (phone.length != 10) {
        errMsg = "Invalid Phone Format";
      } else if (!phone.isEmpty && !Amount.isEmpty && phone.length == 10) {
        payBtn = true;
        errMsg = null;
      } else {
        payBtn = false;
        errMsg = null;
      }
    });
  }


  Future authorizeAccessContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true);
      setState(() {
        myContacts = contacts;
      });
      print(myContacts);
    } else {
      print("User has denied access to contacts");
    }
  }


  Widget chooseAccount() {
    return Autocomplete<Contact>(
      optionsMaxHeight: 450.0,
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Contact> onSelected, Iterable<Contact> options){
return Material(
  elevation: 4.0,
  child: ListView(
    children: options.map((contact){
      return ListTile(
        title:Text(contact.displayName) ,
    subtitle: Text(
      contact.phones.isNotEmpty ? contact.phones.first.normalizedNumber:"no Phone Number available"
    ),
    onTap: (){
          onSelected(contact);
    },
    );
    }).toList(),
  ),
);
      },
      optionsBuilder: (TextEditingValue pochiName) {
        print("Searching form ${pochiName.text}");
        print(myContacts);
        if (pochiName.text.isEmpty) {
          return myContacts;
        }
        return myContacts.where((Contact poch) {
          return poch.displayName.toLowerCase().contains(
              pochiName.text.toLowerCase());
        });
      },
      displayStringForOption: (Contact pochi) => pochi.displayName,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController, FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (String text) {
            onFieldSubmitted();
          },
          decoration: InputDecoration(
              hintText: "Search Number/Pochi"
          ),
        );
      },
      onSelected: (Contact cont) {
        if (cont.phones.isNotEmpty) {
          setState(() {
            phoneNumber.text =
                cont.phones.first.normalizedNumber.replaceAll("+254", '0');
            choosePochi = false; // Set this to false after selecting a contact
          });
        } else {
          print("No phone number available");
        }
      },
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumber.dispose();
    amount.dispose();
  }

  @override
  void initState() {
    super.initState();
    phoneNumber.addListener(validator);
    amount.addListener(validator);
    authorizeAccessContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          choosePochi ? chooseAccount() :
          Column(
            children: [
              TextField(
                controller: phoneNumber,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  errorText: errMsg,
                  suffixIcon: IconButton(
                    onPressed: () {
                      print(myContacts);
                      setState(() {
                        choosePochi = true; // Set to true to show contact list
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: 60.0),
              TextField(
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount",
                ),
              ),
              SizedBox(height: 55.0),
              FilledButton(
                onPressed: payBtn ? () {} : null,
                child: Text("Pay"),
                style: ButtonStyle(
                  backgroundColor: payBtn
                      ? MaterialStateProperty.all(Colors.green.shade600)
                      : MaterialStateProperty.all(Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}