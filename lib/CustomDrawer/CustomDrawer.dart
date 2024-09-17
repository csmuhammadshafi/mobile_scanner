import 'package:flutter/material.dart';
import 'package:mobile_scanner/HomePage.dart';
import 'package:mobile_scanner/picture.dart';
import '../AppInfo/AppInfo.dart';
import '../Setting.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Text(
              'Mobile Scanner',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));

            },
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Previous Documents'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PictureListScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App Info'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AppInfo()));

            },
          ),
        ],
      ),
    );
  }
}
