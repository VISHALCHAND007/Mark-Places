import 'dart:io';

import 'package:flutter/material.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({super.key});

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  File? _storedImage;

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
            onPressed: () {},
            icon: Icon(Icons.camera, size: 22),
            label: Text("Take Picture", style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }
}
