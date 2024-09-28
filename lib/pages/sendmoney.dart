import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Sendmoney extends StatelessWidget {
  const Sendmoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Send Money Conveniently",
          style: TextStyle(
            fontSize: 19.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Mpesaform(),
    );
  }
}

// Form widget
class Mpesaform extends StatefulWidget {
  const Mpesaform({super.key});

  @override
  State<Mpesaform> createState() => _MpesaformState();
}

class _MpesaformState extends State<Mpesaform> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController amount = TextEditingController();

  String? phoneError;
  String? amountError;
  bool showBtn = false;
  List<Contact> contacts = [];
  bool chooseContact = false;

  Future FetchContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      List<Contact> myContacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        contacts = myContacts;
      });
    } else {
      print("Permission denied");
    }
  }

  Widget contactList() {
    return Autocomplete<Contact>(
      optionsMaxHeight: 300.0,
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Contact> onSelected, Iterable<Contact> options){
        return Material(
          elevation: 4.0,
          child: ListView(
            children: options.map((contact){
              return ListTile(
                title:Text(contact.displayName) ,
                subtitle: Text(
                  contact.phones.isNotEmpty ? contact.phones.first.normalizedNumber:"no phone number available"
                ),
                onTap: (){onSelected(contact);
                },
              );
            }).toList(),
          ),
        );
      },
      optionsBuilder: (TextEditingValue nameList) {
        if (nameList.text.isEmpty) {
          return contacts;
        }
        return contacts.where((Contact cont) {
          return cont.displayName
              .toLowerCase()
              .contains(nameList.text.toLowerCase());
        });
      },
      displayStringForOption: (Contact contact) => contact.displayName,
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Type to search contacts',
          ),
          onSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: (Contact c) {
        if (c.phones.isNotEmpty) {
          print(c.phones.first.number);

          setState(() {
            phoneNumber.text = c.phones.first.normalizedNumber.replaceAll("+254", "0");
            chooseContact = false;
          });
        } else {
          print('No phone number available for this contact.');
          setState(() {
            phoneNumber.clear();
            chooseContact = false;
          });
        }
      },
    );
  }


  void validateandapproveinputs() {
    final phone = phoneNumber.text;
    final Amount = amount.text;

    setState(() {
      if (phone.length != 10) {
        phoneError = "This format is invalid. Provide a valid phone format";
      } else {
        phoneError = null;
      }
      showBtn = phone.length == 10 && !Amount.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    phoneNumber.addListener(validateandapproveinputs);
    amount.addListener(validateandapproveinputs);
    FetchContacts();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Ensure form key is properly set here
      child: chooseContact
          ? contactList()
          : Column(
        children: [
          TextField(
            maxLength: 10,
            controller: phoneNumber,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Kindly Enter Phone Number",
              errorText: phoneError,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    chooseContact = true;
                  });
                },
                icon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          TextField(
            controller: amount,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Amount",
              errorText: amountError,
            ),
          ),
          SizedBox(height: 37.0),
          FilledButton(
            onPressed: showBtn ? () {} : null,
            child: Text("Send Money"),
            style: ButtonStyle(
              backgroundColor: showBtn
                  ? MaterialStateProperty.all(Colors.green)
                  : MaterialStateProperty.all(Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
