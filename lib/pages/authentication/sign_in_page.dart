import 'package:flutter/material.dart';
import 'package:property_manager/services/authentication_service.dart';
import 'package:property_manager/shared/button_primary.dart';
import 'package:property_manager/shared/form_error.dart';
import 'package:property_manager/shared/form_input.dart';
import 'package:property_manager/shared/validation.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  AuthenticationService _authService;
  String _email = '';
  String _password = '';
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
        _updateIsLoading(true);
        await _authService.signInWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );
        Navigator.of(context).pop();
      } catch (e) {
        _updateError('Failed to log in');
        _updateIsLoading(false);
        print(e.toString());
      }
    }
  }
}
