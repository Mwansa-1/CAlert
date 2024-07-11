// Package imports 
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// Page imports 
import 'main.dart';
import 'blog_details.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.grey[700],
            labelColor: Colors.grey[700],
            tabs: [
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.feed_outlined, size: 30.0),
                    Text(
                      "Blog",
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Icon(Icons.notification_important_outlined, size: 30.0),
                    Text(
                      "Alert",
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          shadowColor: Colors.black,
          title: Text(
            "Feed",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5.5,
          actions: [
            IconButton(
              onPressed: () => GoRouter.of(context).go('/view_all_previous_tests'),
              icon: Icon(Icons.science_outlined),
            ),
            PopupMenuButton<String>(
              onSelected: (String value) {
                switch (value) {
                  case 'New Test':
                    context.go("/new_test");
                    break;
                  case 'Language':
                    // Handle Language change here
                    break;
                  case 'Settings':
                    // Navigate to Settings page
                    break;
                  case 'Sign In':
                    context.go('/login');
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'New Test', 'Language', 'Settings', 'Sign In'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          elevation: 5.0,
          backgroundColor: Colors.grey[800],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          children: [
            SpeedDialChild(
              onTap: () {
                context.go("/new_test");
              },
              child: Icon(Icons.paste_rounded, color: Colors.white),
              label: "New Test With Device",
              backgroundColor: Colors.grey[800],
              labelBackgroundColor: Colors.grey[800],
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    //! Blog
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 50.0),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/c.jpg'),
                            ListTile(
                              onTap: () {
                                // Navigate to blog details
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const BlogDetailsPage()),
                                );
                              },
                              tileColor: Colors.white,
                              title: Text("Blog Post 1"),
                              subtitle: Text(
                                "Lorem Ipsum",
                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ListView(
              children: [
                Column(
                  children: [
                    //! Alert
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 50.0),
                      child: Container(
                        height: 57.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0.0,
                              blurRadius: 1.0,
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.emergency_share_outlined,
                                color: Colors.red,
                                size: 16.0,
                              ),
                            ),
                            Text(
                              "Lusaka",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.new_label_outlined,
                                  size: 16.0,
                                ),
                                Text("3"),
                              ],
                            ),
                            Text(
                              "14/05/24",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            Icon(Icons.more_vert_outlined),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
