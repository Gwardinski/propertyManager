import 'package:flutter/material.dart';
import 'package:property_manager/shared/loading_spinner.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final onPressed;
  final isLoading;

  const ButtonPrimary({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 128,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        textColor: Colors.white,
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? LoadingSpinner()
            : Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          side: BorderSide(
            width: 1.0,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
