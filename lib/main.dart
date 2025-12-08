import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MisbahaApp());
}

class MisbahaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق تسبيح',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      themeMode: ThemeMode.system,
      home: MisbahaScreen(),
    );
  }
}

class MisbahaScreen extends StatefulWidget {
  @override
  _MisbahaScreenState createState() => _MisbahaScreenState();
}

class _MisbahaScreenState extends State<MisbahaScreen> {
  int subhanallahCount = 0;
  int alhamdulillahCount = 0;
  int allahuAkbarCount = 0;

  void _resetCounters() {
    setState(() {
      subhanallahCount = 0;
      alhamdulillahCount = 0;
      allahuAkbarCount = 0;
    });
    HapticFeedback.mediumImpact();
  }

  Widget _buildTasbeehSection({
    required String label,
    required int count,
    required VoidCallback onPressed,
    required String keyName,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            '$count',
            key: Key(keyName),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              onPressed();
              HapticFeedback.lightImpact();
            },
            child: Icon(Icons.add, size: 28),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(18),
              backgroundColor: color,
              foregroundColor: Colors.white,
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تطبيق تسبيح',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTasbeehSection(
                label: 'سبحان الله',
                count: subhanallahCount,
                onPressed: () {
                  setState(() {
                    subhanallahCount++;
                  });
                },
                keyName: 'subhanallah-count',
                color: const Color.fromARGB(255, 2, 131, 54),
              ),
              _buildTasbeehSection(
                label: 'الحمد لله',
                count: alhamdulillahCount,
                onPressed: () {
                  setState(() {
                    alhamdulillahCount++;
                  });
                },
                keyName: 'alhamdulillah-count',
                color: const Color.fromARGB(255, 2, 131, 54),
              ),
              _buildTasbeehSection(
                label: 'الله أكبر',
                count: allahuAkbarCount,
                onPressed: () {
                  setState(() {
                    allahuAkbarCount++;
                  });
                },
                keyName: 'allahuakbar-count',
                color: const Color.fromARGB(255, 2, 131, 54),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _resetCounters,
                icon: Icon(Icons.refresh),
                label: Text('تصفير العدادات'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 131, 54),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}