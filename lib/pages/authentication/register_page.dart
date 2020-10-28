import 'package:flutter/material.dart';
import 'package:property_manager/services/authentication_service.dart';
import 'package:property_manager/shared/button_primary.dart';
import 'package:property_manager/shared/form_error.dart';
import 'package:property_manager/shared/form_input.dart';
import 'package:property_manager/shared/validation.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  AuthenticationService _authService;
  String _email = '';
  String _password = '';
  String _name = '';
  String _error = '';
  bool _isLoading = false;

  @override
  // required by AutomaticKeepAliveClientMixin
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _authService = Provider.of<AuthenticationService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      FormInput(
                        validate: validateForm,
                        labelText: "Name",
                        disabled: _isLoading,
                        onChanged: (String val) {
                          setState(() {
                            _name = val;
                          });
                        },
                      ),
                      FormInput(
                        validate: validateEmail,
                        labelText: "Email",
                        disabled: _isLoading,
                        onChanged: (String val) {
                          setState(() {
                            _email = val;
                          });
                        },
                      ),
                      FormInput(
                        validate: validatePassword,
                        labelText: "Password",
                        obscureText: true,
                        disabled: _isLoading,
                        onChanged: (String val) {
                          setState(() {
                            _password = val;
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
        await _authService.registerWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
          displayName: _name.trim(),
        );
        Navigator.of(context).pop();
      } catch (e) {
        _updateError('Failed to register');
        _updateIsLoading(false);
        print(e.toString());
      }
    }
  }
}
