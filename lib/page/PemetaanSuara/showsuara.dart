import 'package:flutter/material.dart';

class shadowsuara extends StatefulWidget {
  const shadowsuara({super.key});

  @override
  State<shadowsuara> createState() => _shadowsuaraState();
}

class _shadowsuaraState extends State<shadowsuara> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200, 
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: shadowsuara(),
  ));
}
