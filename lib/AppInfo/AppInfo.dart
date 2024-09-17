import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mobile Scanner App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Version: 1.0.0',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Mobile Scanner is a user-friendly app designed to scan documents, '
                  'convert them into PDF, and store them efficiently. With advanced '
                  'features like document enhancement, and PDF sharing. '
                  'this app is a perfect solution for managing your paperwork on the go.',
              style: TextStyle(fontSize: 16.0),
            ),

            SizedBox(height: 24),
            Text(
              'Founder & CEO',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),

            ),
            SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/aa.jpg')
              ),

              title: Text('Muhammad Shafi'),
              subtitle: Text('Founder & CEO'),
            ),

            SizedBox(height: 24.0),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),

            Row(
              children: [
                Icon(Icons.email),
                SizedBox(width: 8.0),
                Text('csmuhammadshafi.com', style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}