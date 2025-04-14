import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  const ImagePickerField({super.key});

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final List<XFile> images = [];

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => images.add(image));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Add Photos:"),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              images
                  .map(
                    (img) => Image.file(
                      File(img.path),
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.photo),
          label: const Text("Pick Image"),
        ),
      ],
    );
  }
}
