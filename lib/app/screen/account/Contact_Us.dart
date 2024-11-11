import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';

class ContactUsScreen extends StatefulWidget{
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(

       appBar: CustomAppBar(
         title: 'Contact Us',

         isBackButtonExist: true,
       ),
     body:  Stack(
       children:[ Container(
        // width: 200,
         height: 300,
           decoration: BoxDecoration(
           image: DecorationImage(
           image: AssetImage("assets/images/contactlogo.png",),
           fit: BoxFit.cover,
           ),
           ),

          ),
         Center(
           child: Padding(
             padding: const EdgeInsets.only(top: 297),
             child: Container(
               width: 450,
               height: 400,

               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5),
                 border: Border.all(
                  // color: Colors.red,
                   width: 2,
                 ),
                 color: Colors.white,
               ),child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                             width: 50,
                             height: 40, color: Colors.green,
                             child: Icon(Icons.phone)),
                         SizedBox(width: 40,),
                         Container(
                             width: 50,
                             height: 40, color: Colors.green,
                             child: Icon(Icons.email)),
                       ],
                     ),
                     SizedBox(height: 40,),
                     Text("CONTACT US",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 30),),
                     SizedBox(height: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Website:-",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                         Text(" http//client//.in",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Mail:-",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                         Text("xyz@gmail.com",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Contact no:-",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                         Text(" 7654689643",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                       ],
                     ),
                   ],
                 ),
               ),

             ),
           ),
         ),
           ] ),);
  }
}
//img_crop_doctor.png