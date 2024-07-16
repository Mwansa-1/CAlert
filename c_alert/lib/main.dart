import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'BluetoothDeviceListEntry.dart';
import 'package:go_router/go_router.dart';

//Pages import 
import 'home_page.dart';
import 'nav.dart';
import 'feed.dart';
import 'profile.dart';
import 'new_test.dart';
import 'home.dart';
import 'more_info.dart';
import 'previous_tests.dart';
import 'bluetooth_scan.dart';
import 'detailspage.dart';
import 'result.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cholera Alert',
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
      )
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      // MAIN PAGES
      //Home Page
      GoRoute(
        path: '/',
        builder: (context, state) => Nav(
          child: const HomePage(),
          currentIndex: 0,
        ),
        //On the home page there are some links to other pages 
        routes:[
          GoRoute(
            path: 'new_test',
            builder: (context, state) => Nav(
              child: const NewTestPage(),
              currentIndex: 0,
            ),
          ),
          GoRoute(
            path: 'more_info',
            builder: (context, state) => Nav(
              child: const MoreInfoPage(),
              currentIndex: 0,
            ),
            routes:[
          GoRoute(
            path: 'new_test',
            builder: (context, state) => Nav(
              child: const NewTestPage(),
              currentIndex: 0,
            ),
          ),
        ]
          ),
          GoRoute(
            path: 'view_all_blog_posts',
            builder: (context, state) => Nav(
              child: const FeedPage(),
              currentIndex: 1,
            ),
            routes:[
          GoRoute(
            path: 'new_test',
            builder: (context, state) => Nav(
              child: const NewTestPage(),
              currentIndex: 0,
            ),
          ),
        ]
          ),
          GoRoute(
            path: 'result',
            builder: (context, state) => Nav(
              child: const ResultPage(),
              currentIndex: 0,
            ),
          ),
          GoRoute(
            path: 'view_all_previous_tests',
            builder: (context, state) => const Nav(
              child: const PreviousTestsPage(),
              currentIndex: 0,
            ),
            routes:[
          GoRoute(
            path: 'new_test',
            builder: (context, state) => Nav(
              child: const NewTestPage(),
              currentIndex: 0,
            ),
          ),
        ]
          ),
        ]
      ),
      //Scan Results 
      // GoRoute(
      //     path: '/scanResults',
      //     builder: (context, state) => Nav(
      //       child: const ScanResults(),
      //       currentIndex: 3,
      //     ),
      //   ),
      //Feed Page
      GoRoute(
        path: '/feed',
        builder: (context, state) => Nav(
          child: const FeedPage(),
          currentIndex: 1,
        ),
        // routes:[
        //   GoRoute(
        //     path: 'blog_details',
        //     builder: (context, state) => Nav(
        //       child: const BlogDetailsPage(),
        //       currentIndex: 0,
        //     ),
        //     routes:[
        //   GoRoute(
        //     path: 'new_test',
        //     builder: (context, state) => Nav(
        //       child: const NewTestPage(),
        //       currentIndex: 0,
        //     ),
        //   ),
        // ]
        //   ),
        // ]
      ),
      //Profile Page
      GoRoute(
        path: '/profile',
        builder: (context, state) =>Nav(
          child: const ProfilePage(),
          currentIndex: 2,
        ),
        routes:[
          GoRoute(
            path: 'new_test',
            builder: (context, state) => Nav(
              child: const NewTestPage(),
              currentIndex: 0,
            ),
          ),
        ]
      ),
      //Bluetooth Scan Page 
      GoRoute(
        path: '/bluetooth_scan',
        builder: (context, state) => Nav(
              child: const BluetoothScan(),
              currentIndex: 0,
        ),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) {
          final server = state.extra as BluetoothDevice;
          return Nav(
            child : DetailPage(server: server),
            currentIndex: 0,
            );
        },
      ),
      // GoRoute(
      //       path: '/dashboard',
      //       builder: (context, state) =>  Dashboard(),
      //     ),
    ]
  );
}


