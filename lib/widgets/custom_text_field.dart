import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller; // Adicionando o controlador

  CustomTextField({
    required this.hintText,
    this.obscureText = false,
    this.controller, // Incluindo o controlador como parâmetro opcional
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Usando o controlador aqui
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}
