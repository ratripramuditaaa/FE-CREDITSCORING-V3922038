import 'package:flutter/material.dart';

class TextFormGlobal extends StatelessWidget {
  const TextFormGlobal({
    Key? key,
    required this.controller,
    required this.text,
    required this.textInputType,
    this.obscure = false,
    this.icon,
    this.suffixIcon,
    this.showPasswordToggle = false,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool showPasswordToggle;
  final FormFieldValidator<String>? validator; 
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 3, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obscure,
        textAlignVertical: TextAlignVertical.center, // Menyusun teks vertikal ke tengah
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), // Sesuaikan padding sesuai kebutuhan
          hintStyle: TextStyle(height: 1),
          prefixIcon: icon != null ? Icon(icon) : null,
          suffixIcon: showPasswordToggle ? suffixIcon : null,
        ),
      ),
    );
  }
}
