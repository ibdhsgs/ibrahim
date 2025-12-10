import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.person, size: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(email),
                Text(
                  role,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students List')),
      body: ListView(
        children: const [
          UserInfoCard(
            name: 'Ali Ahmed',
            email: 'ali@example.com',
            role: 'Student',
          ),
          UserInfoCard(
            name: 'Sara Mohammed',
            email: 'sara@example.com',
            role: 'Student',
          ),
          UserInfoCard(
            name: 'Yousef Salem',
            email: 'yousef@example.com',
            role: 'Student',
          ),
        ],
      ),
    );
  }
}
