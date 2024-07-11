// Package imports 
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Page imports 
import 'main.dart';


class PreviousTestsPage extends StatefulWidget {
  const PreviousTestsPage ({super.key});

  @override
  State<PreviousTestsPage> createState() => _PreviousTestsPageState();
}

class _PreviousTestsPageState extends State<PreviousTestsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //background color of the app
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text(
          "Previous Tests",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5.5,
        actions: [
          IconButton(onPressed : ()=> GoRouter.of(context).go('view_all_previous_tests'),
                         icon: Icon(Icons.science)),
          IconButton(onPressed: ()=>{}, icon: Icon(Icons.more_vert))
        ],
    
      ),

      body: SingleChildScrollView( 
        child: Column(
          children: <Widget>[
            Padding(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Container(
                  height: 57.0,
                 decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.0,
                      blurRadius: 1.0,
                      offset: Offset(0,1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0)
                  
                 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.science_outlined,
                          size: 16.0,
                        ),
                      ),
                      Text(
                        "Test no.",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          "14/05/24",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            
                          ),
                        ),
                      Row(
                        children: [
                          
                          Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6)
                            ),
                          ),
                         Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.green,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.more_vert_outlined
                      ),
                      
                    ],
                  )
                 ),
                 SizedBox(height: 10.0,),
                 //2nd container
                 Container(
                  height: 57.0,
                 decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0.0,
                      blurRadius: 1.0,
                      offset: Offset(0,1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0)
                  
                 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.science_outlined,
                          size: 16.0,
                        ),
                      ),
                      Text(
                        "Test no.",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                          "14/05/24",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            
                          ),
                        ),
                      Row(
                        children: [
                          
                          Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6)
                            ),
                          ),
                         Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.green,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.more_vert_outlined
                      ),
                      
                    ],
                  )
                 ),
                
              ],
              
            ),
          ),
          ],
        )
      )
    );
  }
}