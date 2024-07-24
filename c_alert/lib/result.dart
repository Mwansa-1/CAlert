import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _showDetailedResults = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color of the app
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text(
          "Test Results",
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
            icon: Icon(Icons.science_outlined)
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

      // Floating action button
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

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Cholera Detection Test',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
            const SizedBox(height: 16),
            _buildCard(
              title: 'Results',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Positive',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Quantitative Analysis: High level of contamination detected.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showDetailedResults = !_showDetailedResults;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(_showDetailedResults ? 'Show Less' : 'Show More'),
              ),
            ),
            if (_showDetailedResults) ...[
              const SizedBox(height: 16),
              _buildCard(
                title: 'Methodology',
                child: _buildMethodSection(),
              ),
              SizedBox(height: 20.0,)
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      
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
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Test Used',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text('Rapid Cholera Detection Test', style: TextStyle(color: Colors.black)),
        SizedBox(height: 8),
        Text(
          'Purpose of the Test',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text('To quickly identify the presence of cholera bacteria.', style: TextStyle(color: Colors.black)),
        SizedBox(height: 8),
        Text(
          'Principle of the Method',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text('The test detects cholera bacteria through antigen-antibody reactions.', style: TextStyle(color: Colors.black)),
        SizedBox(height: 8),
        Text(
          'Limitations of the Test',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text('Can only detect 01 and 130 serotypes of Vibrio Cholerae.', style: TextStyle(color: Colors.black)),
        SizedBox(height: 8),
        Text(
          'How was the test done?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text('A sample was taken and analyzed using the automated rapid detection kit.', style: TextStyle(color: Colors.black)),
        SizedBox(height: 8),
        Text(
          'Sensitivity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 4),
        Text('High sensitivity (95%)', style: TextStyle(color: Colors.black)),
        SizedBox(height: 8),
        Text(
          'Specificity?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        SizedBox(height: 4),
        Text('High specificity (98%)', style: TextStyle(color: Colors.black)),
        
      ],
    );
  }
}
