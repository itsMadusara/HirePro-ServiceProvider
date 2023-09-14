import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleEyeField extends StatefulWidget {
  ToggleEyeField({
    super.key,
    required bool obscureText,
    required IconData icon,
    required String placeholder,
    required TextEditingController controller,
  })  : _obscureText = obscureText,
        _icon = icon,
        _placeholder = placeholder,
        _controller = controller;

  bool _obscureText;
  IconData _icon;
  String _placeholder;
  TextEditingController _controller;

  @override
  State<ToggleEyeField> createState() => _ToggleEyeFieldState();
}

class _ToggleEyeFieldState extends State<ToggleEyeField> {
  void _toggleVisibility() {
    setState(() {
      // print('tapped');
      widget._obscureText = !widget._obscureText;
      widget._icon = widget._obscureText
          ? FontAwesomeIcons.eyeSlash
          : FontAwesomeIcons.eye;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      obscureText: widget._obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: GestureDetector(
          onTap: _toggleVisibility,
          child: Icon(
            widget._icon,
            size: 15,
          ),
        ),
        hintText: widget._placeholder,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
