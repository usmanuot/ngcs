import 'package:flutter/material.dart';

class PictureUploadWidget extends StatefulWidget {
  @override
  _PictureUploadWidgetState createState() => _PictureUploadWidgetState();
}

class _PictureUploadWidgetState extends State<PictureUploadWidget> {
  // Placeholder for the selected image. You can use the ImageProvider you prefer.
  // For example, FileImage for images from the device or NetworkImage for online images.
  ImageProvider? _image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[300], // Placeholder background color
            borderRadius: BorderRadius.circular(8.0),
          ),
          // Display the selected image or a placeholder if no image is selected.
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(
                    image: _image!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(
                  Icons.add, // Placeholder icon when no image is selected
                  size: 60,
                  color: Colors.grey[600],
                ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onDoubleTap: _removeImage,
              borderRadius: BorderRadius.circular(8.0),
              onTap: _selectImage,
            ),
          ),
        ),
      ],
    );
  }

  // Function to handle image selection.
  // Here, you can use ImagePicker or any other method to select an image.
  // For simplicity, we will use a placeholder image for demonstration purposes.
  void _selectImage() {
    setState(() {
      // For example, replace this with the image selected from ImagePicker.
      // For now, we'll use a placeholder image from assets.
      _image = const AssetImage('assets/images/ngcs.jpg');
    });
  }

  void _removeImage() {
    setState(() {
      // For example, replace this with the image selected from ImagePicker.
      // For now, we'll use a placeholder image from assets.
      // _image = ;
    });
  }
}
