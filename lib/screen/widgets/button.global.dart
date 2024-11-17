import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/global.color.dart';

class ButtonGlobal extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ButtonGlobal({
    Key? key,
    this.text = 'Sign In', // Default text for button
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
