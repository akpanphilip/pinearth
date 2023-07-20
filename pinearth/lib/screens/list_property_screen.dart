import 'package:flutter/material.dart';

class ListPropertyScreen extends StatefulWidget {
  const ListPropertyScreen({super.key});

  @override
  State<ListPropertyScreen> createState() => _ListPropertyScreenState();
}

class _ListPropertyScreenState extends State<ListPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('List property screen'),
      ),
    );
  }
}