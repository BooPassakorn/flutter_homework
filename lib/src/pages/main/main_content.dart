import 'package:flutter/material.dart';

class MainContent extends StatelessWidget {
  MainContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              thickness: 1,
              height: 70,
            ),
            Text("MainContent Is Coming Soon"),
          ],
        ),
      ),
    );
  }
}
