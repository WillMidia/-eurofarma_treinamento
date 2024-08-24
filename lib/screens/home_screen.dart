import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'profile_screen.dart';
import 'training_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Perfil',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Treinamentos',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainingScreen(),
                  ),
                );
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
