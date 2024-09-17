
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner Settings',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
            Container(height:100,child: Card(color: Colors.white54,child: ListTile())),
          ],
        ),
      ),
    );
  }
}
