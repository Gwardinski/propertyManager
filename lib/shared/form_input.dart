import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final onChanged;
  final validate;
  final labelText;
  final obscureText;
  final disabled;
  final keyboardType;

  const FormInput({
    Key key,
    @required this.onChanged,
    @required this.validate,
    @required this.labelText,
    this.obscureText = false,
    this.disabled = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        enabled: disabled != true,
        validator: validate,
        maxLines: 1,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: true,
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            borderSide: BorderSide(
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: Theme.of(context).accentColor,
            ),
          ),
          errorStyle: TextStyle(
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
