import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Results',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Positive or Negative Projections',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showDetailedResults = !_showDetailedResults;
                  });
                },
                child: Text(_showDetailedResults ? 'Show Less' : 'Show More'),
              ),
            ),
            if (_showDetailedResults) ...[
              const SizedBox(height: 16),
              const Text(
                'Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildMethodSection(),
              const SizedBox(height: 16),
              const Text(
                'Quantitative Analysis',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'The degree of the contamination.',
                style: TextStyle(fontSize: 16),
              ),
            ],
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
          'What test did you use?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('Description of the test.'),
        SizedBox(height: 8),
        Text(
          'What is the purpose of the method?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('Purpose of the method.'),
        SizedBox(height: 8),
        Text(
          'What is the principle of the method?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('Principle of the method.'),
        SizedBox(height: 8),
        Text(
          'What are some of the limitations of the results?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('Limitations of the results.'),
        SizedBox(height: 8),
        Text(
          'How was the test done?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('Description of the test procedure.'),
        SizedBox(height: 8),
        Text(
          'What is the sensitivity?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('Sensitivity details.'),
        SizedBox(height: 8),
        Text(
          'What is the specificity?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text('Specificity details.'),
      ],
    );
  }
}
