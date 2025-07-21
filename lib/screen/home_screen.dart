 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

   @override
   Widget build(BuildContext context)
   {
     return  Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.indigoAccent,
         title: Text("Home Screen"),
         centerTitle: true,
       ),
       body: SingleChildScrollView(
         child: Column(
           children:
           [
             Container(
               margin: EdgeInsets.all(12),
               decoration: BoxDecoration(
                 color: Colors.indigoAccent.withOpacity(0.3),
                 borderRadius: BorderRadius.circular(5)
               ),
               child: TextField(
                 onChanged: (value)
                 {
                   if (kDebugMode)
                   {
                     print('Search input: $value');
                   }
                 },
                 decoration: InputDecoration(

                   hintText: 'Type your city',
                   prefixIcon: Icon(Icons.search),
                   suffixIcon:IconButton(
                     icon: Icon(Icons.clear),
                     onPressed: ()
                     {
                     },
                   ),
                   // filled: true,
                   // fillColor: Colors.grey[200],
                   contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(30.0),
                     borderSide: BorderSide.none,
                   ),
                 ),
               ),
             )

           ],
         ),
       ),
     );
   }
 }
