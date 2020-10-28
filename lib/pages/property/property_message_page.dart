import 'package:flutter/material.dart';
import 'package:property_manager/models/property_model.dart';
import 'package:property_manager/shared/button_primary.dart';
import 'package:property_manager/shared/form_error.dart';
import 'package:property_manager/shared/form_input.dart';
import 'package:property_manager/shared/validation.dart';

class PropertyMessagePage extends StatefulWidget {
  final PropertyModel propertyModel;

  PropertyMessagePage({
    @required this.propertyModel,
  });

  @override
  _PropertyMessagePageState createState() => _PropertyMessagePageState();
}

class _PropertyMessagePageState extends State<PropertyMessagePage> {
  final _formKey = GlobalKey<FormState>();

  String _message = '';
  String _error = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Property"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text("Contact ${widget.propertyModel.title}"),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      FormInput(
                        validate: validateForm,
                        labelText: "Message",
                        disabled: _isLoading,
                        onChanged: (String val) {
                          setState(() {
                            _message = val;
                          });
                        },
                      ),
                      ButtonPrimary(
                        text: "Submit",
                        isLoading: _isLoading,
                        onPressed: _isLoading ? null : _onSubmit,
                      ),
                      FormError(error: _error),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateError(String val) {
    setState(() {
      _error = val;
    });
  }

  _updateIsLoading(bool val) {
    setState(() {
      _isLoading = val;
    });
  }

  _onSubmit() async {
    if (_formKey.currentState.validate()) {
      try {
        _updateIsLoading(true);
        await Future.delayed(Duration(seconds: 2));
        Navigator.of(context).pop();
      } catch (e) {
        _updateError('Failed to log in');
        _updateIsLoading(false);
        print(e.toString());
      }
    }
  }
}
