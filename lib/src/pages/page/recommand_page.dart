import 'package:flutter/material.dart';

class RecommandPage extends StatelessWidget {
  const RecommandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Find what you're looking for",
              prefixIcon: Icon(Icons.search, color: Colors.black),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 13),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  color: Colors.black
                )
              ),
            ),
          ),
        ),
      ),
      body: Center(child: Text('Coming Soon')),
    );
  }
}
