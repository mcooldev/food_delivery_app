import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/fonts.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.label,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.showIcon = true,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final FormFieldValidator validator;
  final bool showIcon;
  final String label, hintText;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorErrorColor: Colors.red,
      validator: widget.validator,
      obscureText: obscure,
      cursorColor: purple,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.onFieldSubmitted != null ?
      TextInputAction.next : TextInputAction.done,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        suffixIcon:
            widget.showIcon
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  icon:
                      obscure
                          ? const Icon(Icons.visibility_outlined, color: Colors.black)
                          : const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black,
                          ),
                )
                : null,
        label: Text(widget.label),
        labelStyle: bodyText,
        hintText: widget.hintText,
        hintStyle: bodyText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelStyle: const TextStyle(color: Colors.deepPurpleAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
