import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  static const routeName = '/Admin-page';

  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgroundimage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Set your desired margins here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome back Admin!',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context,'/add-user');
                          },
                          child: const Text('Add User'),
                        ),
                        SizedBox(height: 10), // Add space between buttons
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/modify-user');
                          },
                          child: const Text('Modify User'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add-match');
                          },
                          child: const Text('Add Match'),
                        ),
                        SizedBox(height: 10), // Add space between buttons
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/modify-match');
                          },
                          child: const Text('Modify Match'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: AdminHomeScreen()));
}