import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File) onImagePick;

  const UserImagePicker({required this.onImagePick, super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: Platform.isAndroid ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }

    // setting image from picked image
    setState(() => _image = File(pickedImage.path));

    // add on callback
    widget.onImagePick(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.black54,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton(
            onPressed: () async => _pickImage(),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  color: Colors.blueAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Adicionar imagem',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ))
      ],
    );
  }
}
