import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CropingImage extends StatefulWidget {
  final String imagePath;

  CropingImage({required this.imagePath});

  @override
  _CropingImageState createState() => _CropingImageState();
}

class _CropingImageState extends State<CropingImage> {
  bool _isBlackAndWhite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crop Image',
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
        actions: [
          IconButton(
            icon: Icon(
              _isBlackAndWhite ? Icons.color_lens : Icons.grain,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isBlackAndWhite = !_isBlackAndWhite;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 200,
                child: ColorFiltered(
                  colorFilter: _isBlackAndWhite
                      ? ColorFilter.matrix(
                    <double>[
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0, 0, 0, 1, 0,
                    ],
                  )
                      : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                  child: Image.file(File(widget.imagePath)),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              onPressed: () async {
                await _saveImageToHive();
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Image added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveImageToHive() async {
    final box = Hive.box('documentsBox');
    final imageFile = File(widget.imagePath);

    // Read the image as bytes
    final Uint8List imageBytes = await imageFile.readAsBytes();

    // Convert to black and white if nseeded
    Uint8List processedImageBytes;
    if (_isBlackAndWhite) {
      processedImageBytes = await _convertToBlackAndWhite(imageBytes);
    } else {
      processedImageBytes = imageBytes;
    }

    // Save the image along with a flag indicating black-and-white or color
    final pictureData = {
      'image': processedImageBytes,
      'isBlackAndWhite': _isBlackAndWhite,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // Save the picture to Hive
    await box.add(pictureData);
  }

  Future<Uint8List> _convertToBlackAndWhite(Uint8List imageBytes) async {
    // Decode the image
    img.Image originalImage = img.decodeImage(imageBytes)!;

    // Convert to grayscale (black and white)
    img.Image grayscaleImage = img.grayscale(originalImage);

    // Encode the image back to bytes
    return Uint8List.fromList(img.encodeJpg(grayscaleImage));
  }
}
