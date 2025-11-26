import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TextFieldTask(),
  ));
}

class TextFieldTask extends StatefulWidget {
  @override
  _TextFieldTaskState createState() => _TextFieldTaskState();
}

class _TextFieldTaskState extends State<TextFieldTask> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  // copy text
  void copyText() {
    setState(() {
      controller2.text = controller1.text;
    });
  }

  // navigate
  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(
          text: controller1.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.brown[300], // light brown
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                labelText: "Enter your text",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller2,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Result",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: copyText,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[300], // light brown
              ),
              child: Text("Copy Text"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: goToNextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[300], // light brown
              ),
              child: Text("Go to Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String text;

  NextPage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
        backgroundColor: Colors.brown[300],
      ),
      body: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
