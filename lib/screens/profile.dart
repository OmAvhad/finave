import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRI1jWcj1oJKWekoAjIlsLulhheKr-82aDEQw&s',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('John Doe', style: TextStyle(fontSize: 20))),
                Expanded(
                    child: ListView(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile'),
                    ),
                    const ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                )),
              ],
            )),
      ),
    );
  }
}
