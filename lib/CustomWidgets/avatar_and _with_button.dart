import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarWithButton extends StatelessWidget {
  final String imageUrl;
  final double avatarSize;
  final double buttonSize;
  final VoidCallback? onPressed;

  const AvatarWithButton({
    Key? key,
    required this.imageUrl,
    required this.avatarSize,
    required this.buttonSize,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(imageUrl),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: buttonSize,
            height: buttonSize,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.add_circle,
                color: Colors.white,
                size: buttonSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
