import 'package:flutter/material.dart';

import '../classes/wifi.dart';


class WifiPlans extends StatelessWidget {
  const WifiPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, "/home");
        }, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.green.shade600,
        title: Text("Internet Plans",style:
          TextStyle(
            color: Colors.white
          ),),
        centerTitle: true,

      ),
      body: BodyWifi(),
    );
  }
}





class BodyWifi extends StatelessWidget {
   BodyWifi({super.key});

 final List <Wifi> wifiPlans = [
    Wifi(labelButton: "View", logoWifi: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727287272/HOME-SAF_r9joh6.jpg", titleWifi: "Home Plan", wifiDescription: "Get Fast,Reliable internet access at the comfort of your home."),
    Wifi(labelButton: "Explore", logoWifi: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727287272/HOME-SAF_r9joh6.jpg", titleWifi: "5G Wifi", wifiDescription: "enjoy fast internet speeds all across the major cities"),
   Wifi(labelButton: "View", logoWifi: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727287272/HOME-SAF_r9joh6.jpg", titleWifi: "Kifaru plan", wifiDescription: "Enjoy unlimited wifi connection with this plan"),
   Wifi(labelButton: "View", logoWifi: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727287272/HOME-SAF_r9joh6.jpg", titleWifi: "Kifaru plan", wifiDescription: "Enjoy unlimited wifi connection with this plan")
 ];




 Widget wifiTemp(Wifi wifi){

   return Padding(padding: EdgeInsets.all(15.0),child:
     Card(
       child: Column(
         children: [
           Row(
             children: [
              Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 11.0, 0.0),child:  Image(image: NetworkImage(wifi.logoWifi),height: 22.0,width: 22.0,),),
               Text(wifi.titleWifi),
             ],
           ),
           SizedBox(height: 15.0,),
           Text(wifi.wifiDescription,maxLines: 1,overflow: TextOverflow.ellipsis,),
 Spacer(),

 Padding(padding: EdgeInsets.all(8.0),child:           FilledButton(onPressed: (){}, child: Text(wifi.labelButton),style:
 ButtonStyle(
     backgroundColor: MaterialStateProperty.all(Colors.green.shade600)
 )),)

         ],
       ),
     )
     );

 }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(9.6),child:
      GridView.count(crossAxisCount: 2,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 5.0,


      children: wifiPlans.map((data)=>wifiTemp(data)).toList(),
      ),

      );
  }
}
