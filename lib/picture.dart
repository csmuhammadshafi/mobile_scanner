import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PictureListScreen extends StatefulWidget {
  @override
  _PictureListScreenState createState() => _PictureListScreenState();
}

class _PictureListScreenState extends State<PictureListScreen> {
  late Box _picturesBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    _picturesBox = await Hive.openBox('documentsBox');
    setState(() {}); // Refresh UI after box is opened
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Pictures'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: _picturesBox.isOpen && _picturesBox.isNotEmpty
          ? ListView.builder(
        itemCount: _picturesBox.length,
        itemBuilder: (context, index) {
          final pictureData = _picturesBox.getAt(index);

          // Ensure all necessary data exists and is not null
          if (pictureData == null ||
              pictureData['image'] == null ||
              pictureData['isBlackAndWhite'] == null ||
              pictureData['timestamp'] == null) {
            return SizedBox();
          }

          final Uint8List imageBytes = pictureData['image'];
          final bool isBlackAndWhite = pictureData['isBlackAndWhite'];
          final String timestamp = pictureData['timestamp'];

          return Card(
            color: Colors.white38,
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for the image
                child: Image.memory(
                  imageBytes,
                  width: 50, // Set a fixed width
                  height: 50, // Set a fixed height
                  fit: BoxFit.cover, // Fit the image inside the box
                ),
              ),
              title: Text(
                isBlackAndWhite ? 'Black & White Image' : 'Color Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              subtitle: Text(timestamp),
              onTap: () {
                // Navigate to the detail screen with the image data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PictureDetailScreen(
                      imageBytes: imageBytes,
                      isBlackAndWhite: isBlackAndWhite,
                      timestamp: timestamp,
                    ),
                  ),
                );
              },
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No pictures saved yet.',
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ),
    );
  }
}

// Picture Detail Screen to show the selected image
class PictureDetailScreen extends StatelessWidget {
  final Uint8List imageBytes;
  final bool isBlackAndWhite;
  final String timestamp;

  PictureDetailScreen({
    required this.imageBytes,
    required this.isBlackAndWhite,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isBlackAndWhite ? 'Black & White Image' : 'Color Image'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners for the displayed image
              child: Image.memory(
                imageBytes,
                width: 300, // Set a larger width
                height: 300, // Set a larger height
                fit: BoxFit.cover, // Fit the image inside the box
              ),
            ),
            SizedBox(height: 20), // Add some space
            Text(
              'Saved on: $timestamp',
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
