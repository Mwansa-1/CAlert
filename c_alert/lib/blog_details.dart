// Package imports 
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Page imports 
import 'main.dart';


class BlogDetailsPage extends StatefulWidget {
  const BlogDetailsPage ({super.key});

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //background color of the app
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text(
          "Stats",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5.5,
        actions: [
          IconButton(onPressed : ()=> GoRouter.of(context).go('view_all_previous_tests'),
                         icon: Icon(Icons.science_outlined)),
          IconButton(onPressed: ()=>{}, icon: Icon(Icons.more_vert))
        ],
    
      ),
    );
  }
}