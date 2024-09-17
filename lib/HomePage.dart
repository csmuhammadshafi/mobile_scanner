import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/CropingImage/CropingImage.dart';
import 'package:mobile_scanner/CustomDrawer/CustomDrawer.dart';
import 'Setting.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  Box? documentsBox;

  @override
  void initState() {
    super.initState();
    documentsBox = Hive.box('documentsBox');
  }

  Future<void> _captureImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Save the document into Hive directly
      final document = {
        'name': 'Document ${DateTime.now()}',
        'path': image.path
      };
      documentsBox?.add(document);

      // Go to review screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CropingImage(imagePath: image.path)),
      );
    }
  }

  Future<void> _selectImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Save the document into Hive directly
      final document = {
        'name': 'Document ${DateTime.now()}',
        'path': image.path
      };
      documentsBox?.add(document);

      // Go to review screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CropingImage(imagePath: image.path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Scanner Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _captureImageFromCamera,
              icon: Icon(Icons.camera_alt_rounded, size: 150),
            ),
            IconButton(
              onPressed: _selectImageFromGallery,
              icon: Icon(Icons.image, size: 150),
            ),
          ],
        ),
      ),
    );
  }
}
