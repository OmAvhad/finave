import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: Center(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 20, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Track Your Spending Effortlessly',
                      style: TextStyle(
                          fontSize: 68,
                          height: 1.2,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Manage your finances easily using our intutive and user-friendly interface and set financial goals and monitor your progress',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300, height: 1.4),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Get Started',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.inversePrimary)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // pull the ExpandableListView
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              )
            ],
          ),
        )));
  }
}
