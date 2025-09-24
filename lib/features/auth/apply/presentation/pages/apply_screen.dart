import 'package:flutter/material.dart';
class ApplyScreen extends StatelessWidget {
  const ApplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [const Text('Welcome!!'), const Text('You want to be a delivery man?'),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'country',
          hintText: 'enter country'
          ),
        ),
        
        ],
      ),
    );
  }
}
