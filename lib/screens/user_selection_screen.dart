import 'package:flutter/material.dart';
import 'rh_login_screen.dart';
import 'employee_login_screen.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/eurofarma_logo.png',
                width: 200,
                height: 50,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeLoginScreen(),
                    ),
                  );
                },
                child: Text('Funcionário'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RHLoginScreen(),
                    ),
                  );
                },
                child: Text('RH'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
