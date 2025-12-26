import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class TakePicture extends StatefulWidget {
  final Function onImageSelected;
  const TakePicture(this.onImageSelected, {super.key});

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  File? _storedImage;

  Future<void> _takePicture() async {
    try {
      final imageFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 600);
      if(imageFile != null) {
        setState(() {
          _storedImage = File(imageFile.path);
        });
        final storage = await syspath.getApplicationDocumentsDirectory();
        final fileName = path.basename(imageFile.path);
        final storedImg = await _storedImage?.copy("${storage.path}/$fileName");
        widget.onImageSelected(storedImg);
      }
    } catch(error) {
      print("Error:: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _storedImage == null
              ? Column(
                  mainAxisAlignment: .center,
                  children: [
                    Icon(Icons.image, size: 40),
                    Text("No preview available", textAlign: TextAlign.center),
                  ],
                )
              : Image.file(_storedImage!, fit: BoxFit.cover),
        ),
        SizedBox(width: 15),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera, size: 22),
            label: Text("Take Picture", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
