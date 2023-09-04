import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Picker with Cropping Example',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ImagePickerApp(),
    );
  }
}

class ImagePickerApp extends StatefulWidget {
  @override
  _ImagePickerAppState createState() => _ImagePickerAppState();
}

class _ImagePickerAppState extends State<ImagePickerApp> {
  File? _image;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    // Crop the selected image
    File? croppedImage = await cropImage(image.path);

    if (croppedImage == null) return;

    setState(() {
      this._image = croppedImage;
    });
  }

  Future<File?> cropImage(String imagePath) async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imagePath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1), // Set your desired aspect ratio
      compressQuality: 100, // Set the image quality (0 to 100)
      maxWidth: 800, // Set the maximum width for the cropped image
      maxHeight: 800, // Set the maximum height for the cropped image
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.teal, // Set the toolbar color
        toolbarWidgetColor: Colors.white, // Set the toolbar widget color
        initAspectRatio: CropAspectRatioPreset.square, // Set the initial aspect ratio
        lockAspectRatio: true, // Lock the aspect ratio
      ),
    );

    return croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Image Picker with Cropping')),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(width: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 250,
                width: 250,
                child: _image != null
                    ? Image.file(_image!, width: 250, height: 250, fit: BoxFit.cover,)
                    : Image.network('https://relevant.software/wp-content/uploads/flutter-e1625644676239.png'),
              ),
            ),
            SizedBox(width: 10,),
            CustomButton(
              title: 'Select From Camera',
              icon: Icons.camera_alt_outlined,
              onClick: () => getImage(ImageSource.camera),
            ),
            SizedBox(width: 10,),
            CustomButton(
              title: 'Select From Gallery',
              icon: Icons.image_outlined,
              onClick: () => getImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;

  const CustomButton({
    required this.title,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ElevatedButton(
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10,),
            Text(title),
          ],
        ),
        onPressed: onClick,
      ),
    );
  }
}
