import 'package:flutter/material.dart';
import '../classes/options.dart';

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}





class _HomeState extends State<Home> {
List<Options> Safoptions = [
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "Send Money",routerName: "/send/money"),
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "Lipa na Mpesa",routerName: "/lipa/mpesa"),
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "Airtime top Up",routerName: "/buy/airtime"),
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "Home Internet",routerName: "/home/internet"),
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "Tunukiwa offers",routerName: "/tunukiwa/offers"),
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "Manage Postpay",routerName: "/manage/post/pay"),
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "Data Calls and sms",routerName: "/data/calls"),
  Options(logo: "https://res.cloudinary.com/dasrniwpk/image/upload/v1727241936/DIGIFARM_n40baq.jpg", wordings: "My usage",routerName: "/usage")

];
  String greetings= "";



 Widget safTemp(Options opt,BuildContext ctx){
   return Card(
elevation: 2.0,

     child: Padding(
         padding: EdgeInsets.all(9.5),

     child: Column(
         children: [
           Image(image: NetworkImage(opt.logo),height: 30.0,width: 30.0,),

   SizedBox(height: 10.0,),

   FilledButton(
     style: ButtonStyle(
       backgroundColor: MaterialStateProperty.all(Colors.green.shade600)
     ),
     onPressed: (){
       setState(() {
         Navigator.pushNamed(context, opt.routerName);
       });
     },
     child: Text(opt.wordings,style:
     TextStyle(fontSize: 15.0),),
   )
       ],

     ),
     ),
   );



 }




@override
  void initState() {

    super.initState();
    int time = DateTime.now().hour;
if (time >= 6 && time < 12){
  greetings = "morning";
}else if (time > 12 && time < 17){
  greetings ="afternoon";
}else if (time > 17 && time < 20){
  greetings = "Evening";
}else if (time > 19 && time < 24){
  greetings = "Night";
}
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.green.shade600,
       centerTitle: true,
         title: Column(
           children: [
             Text("Good $greetings",style:
               TextStyle(
                 color: Colors.white,
                 fontSize: 13.0
               ),),
             Text("James Mukumu",style: TextStyle(
               color: Colors.white,
               fontSize: 20.0,
             ),),
           ],
         ),

         bottom: TabBar(tabs: [
           Tab(icon: Icon(Icons.home),child: Text("Home",style: TextStyle(
             color: Colors.white
           ),),),
           Tab(icon: Icon(Icons.waves),child: Text("Mpesa",style: TextStyle(
             color: Colors.white
           ),),),
           Tab(icon: Icon(Icons.card_giftcard),child:
             Text("Discover",style: TextStyle(
               color: Colors.white
             ),),),
           Tab(icon: Icon(Icons.account_circle_sharp),child: Text("Account",style: TextStyle(
             color: Colors.white
           ),),)
         ],
           indicatorColor: Colors.green.shade600, // The color of the tab indicator
           labelColor: Colors.green.shade600, // Color of the selected tab label
           unselectedLabelColor: Colors.black87, // Color of the unselected tab labels
           automaticIndicatorColorAdjustment: true,
           dividerColor: Colors.green.shade600,
         ),
       ),

      body: TabBarView(children: [
        Padding(padding: EdgeInsets.all(8.0),child:
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: Safoptions.map((data)=>safTemp(data,context)).toList(),
        )
          ,),
        Padding(padding: EdgeInsets.all(8.0),child:
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: Safoptions.map((data)=>safTemp(data,context)).toList(),
        )
          ,),
        Padding(padding: EdgeInsets.all(8.0),child:
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: Safoptions.map((data)=>safTemp(data,context)).toList(),
        )
          ,),
        Padding(padding: EdgeInsets.all(8.0),child:
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 5.0,
          children: Safoptions.map((data)=>safTemp(data,context)).toList(),
        )
          ,)
      ])

      ),
    );
  }
}
