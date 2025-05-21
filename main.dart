import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(SchoolLotteryApp());

class SchoolLotteryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Lottery',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LotteryHomePage(),
    );
  }
}

class LotteryHomePage extends StatefulWidget {
  @override
  _LotteryHomePageState createState() => _LotteryHomePageState();
}

class _LotteryHomePageState extends State<LotteryHomePage> {
  final List<String> participants = [];
  String winner = '';
  final TextEditingController _controller = TextEditingController();

  void addParticipant() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        participants.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void pickWinner() {
    if (participants.isNotEmpty) {
      final random = Random();
      setState(() {
        winner = participants[random.nextInt(participants.length)];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('School Lottery')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter student name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addParticipant,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickWinner,
              child: Text('Pick Winner'),
            ),
            SizedBox(height: 20),
            if (winner.isNotEmpty)
              Text('Winner: $winner',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: participants.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(participants[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
